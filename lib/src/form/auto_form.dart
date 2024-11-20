import 'package:auto_form_plus/src/form/abstract/value_pointer.dart';
import 'package:auto_form_plus/src/form/widgets/auto_group_field.dart';
import 'package:flutter/material.dart';

import 'abstract/auto_field_widget.dart';

export 'package:auto_form_plus/src/form/abstract/condition.dart';
export 'package:auto_form_plus/src/form/abstract/field_trigger.dart';
export 'package:auto_form_plus/src/form/abstract/field_validation.dart';
export 'package:auto_form_plus/src/form/abstract/trigger_event.dart';

export 'abstract/auto_field_widget.dart';
export 'widgets/auto_date_field.dart';
export 'widgets/auto_dropdown_field.dart';
export 'widgets/auto_file_field.dart';
export 'widgets/auto_group_field.dart';
export 'widgets/auto_text_field.dart';
export 'widgets/auto_time_field.dart';

class AutoForm extends StatefulWidget {
  final List<Widget> children;
  final void Function(Map<String, String>) onSubmit;

  final String submitButtonLabel;

  final EdgeInsets padding;
  final Map<String, AutoFieldWidget> fields = {};

  final ValuePointer<void Function(String)> setErrorPointer =
      ValuePointer((_) {});
  final ValuePointer<void Function()> clearErrorPointer = ValuePointer(() {});

  void setError(String error) => setErrorPointer.value(error);
  void clearError() => clearErrorPointer.value();

  AutoForm({
    this.children = const [],
    required this.onSubmit,
    this.submitButtonLabel = "Submit",
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

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

  void registerField(AutoFieldWidget field) {
    widget.fields[field.id] = field;
    field.form = widget;
  }

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
                    child: Text(widget.submitButtonLabel),
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

    Map<String, String> data = {};

    for (var f in widget.fields.values) {
      if (f is AutoGroupField) continue;
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
