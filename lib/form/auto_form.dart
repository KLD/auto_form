import 'package:auto_form/form/abstract/value_pointer.dart';
import 'package:flutter/material.dart';

import 'abstract/auto_field_widget.dart';

class AutoForm extends StatefulWidget {
  final List<Widget> children;
  final void Function(Map<String, String>) onSubmit;

  final Map<String, AutoFieldWidget> fields;
  final EdgeInsets padding;

  final ValuePointer<void Function(String)> setErrorPointer =
      ValuePointer((_) {});
  final ValuePointer<void Function()> clearErrorPointer = ValuePointer(() {});

  void setError(String error) => setErrorPointer.value(error);
  void clearError() => clearErrorPointer.value();

  AutoForm({
    this.children = const [],
    required this.onSubmit,
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  }) : fields = {for (var e in children.whereType<AutoFieldWidget>()) e.id: e} {
    for (var f in fields.values) {
      f.form = this;
    }
  }

  @override
  State<AutoForm> createState() => AutoFormState();

  String resolveValue(String value) {
    if (value.startsWith("@")) {
      var targetField = findFieldById(value.substring(1));

      return targetField.value;
    }
    return value;
  }

  AutoFieldWidget findFieldById(String id) {
    return children.whereType<AutoFieldWidget>().firstWhere((e) => e.id == id);
  }
}

class AutoFormState extends State<AutoForm> {
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    widget.setErrorPointer.value = setFromError;
    widget.clearErrorPointer.value = clearFormError;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...widget.children,
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submit,
                    child: const Text("Submit"),
                  )
                ]
                    .map((e) => Padding(padding: widget.padding, child: e))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    var isValidForm = _formKey.currentState!.validate();

    if (!isValidForm) return;

    FocusScope.of(context).unfocus();

    List<AutoFieldWidget> fields =
        widget.children.whereType<AutoFieldWidget>().toList();

    Map<String, String> data = {};

    for (var f in fields) {
      data[f.id] = f.value;
    }

    widget.onSubmit(data);
  }

  void hideField(String id) {
    var field = widget.children
        .whereType<AutoFieldWidget>()
        .firstWhere((e) => e.id == id);

    if (field.isHidden.value) return;

    field.hide();
    setState(() {});
  }

  void showField(String id) {
    var field = widget.children
        .whereType<AutoFieldWidget>()
        .firstWhere((e) => e.id == id);

    if (!field.isHidden.value) return;

    field.show();
    setState(() {});
  }

  void disableField(String id) {
    var field = widget.children
        .whereType<AutoFieldWidget>()
        .firstWhere((e) => e.id == id);

    if (!field.isEnabled.value) return;

    setState(() {
      field.disable();
    });
  }

  void enableField(String id) {
    var field = widget.children
        .whereType<AutoFieldWidget>()
        .firstWhere((e) => e.id == id);

    if (field.isEnabled.value) return;

    setState(() {
      field.enable();
    });
  }

  void setValue(String id, String value) {
    var field = widget.children
        .whereType<AutoFieldWidget>()
        .firstWhere((e) => e.id == id);

    field.setValue(value);
  }

  void setError(String id, String errorMessage) {
    var field = widget.children
        .whereType<AutoFieldWidget>()
        .firstWhere((e) => e.id == id);

    field.setError(errorMessage);
  }

  void clearError() {
    setState(() {
      _errorMessage = null;
    });
  }

  void setFromError(String error) {
    setState(() {
      _errorMessage = error;
    });
  }

  void clearFormError() {
    setState(() {
      _errorMessage = null;
    });
  }
}
