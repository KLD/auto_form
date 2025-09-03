import 'package:auto_form_plus/src/form/abstract/auto_field_state.dart';
import 'package:auto_form_plus/src/form/widgets/auto_group_field.dart';
import 'package:flutter/material.dart';

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

  const AutoForm({
    this.children = const [],
    required this.onSubmit,
    this.submitButtonLabel = "Submit",
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  @override
  State<AutoForm> createState() => AutoFormState();
}

class AutoFormState extends State<AutoForm> {
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  final Map<String, AutoFieldState> fieldStates = {};

  String resolveValue(String value) {
    if (value.startsWith("@")) {
      var targetField = findFieldById(value.substring(1));

      return targetField.value;
    }
    return value;
  }

  AutoFieldState findFieldById(String id) {
    return fieldStates[id]!;
  }

  void registerField(AutoFieldState field) {
    fieldStates[field.widget.id] = field;
  }

  @override
  void initState() {
    super.initState();
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

    for (var f in fieldStates.entries) {
      if (f.value is AutoGroupField) continue;
      data[f.key] = f.value.value;
    }

    widget.onSubmit(data);
  }

  void hideField(String id) {
    var field = findFieldById(id);

    if (field.isHidden) return;

    field.hide();
    setState(() {});
  }

  void showField(String id) {
    var field = findFieldById(id);
    if (!field.isHidden) return;

    field.show();
    setState(() {});
  }

  void disableField(String id) {
    var field = findFieldById(id);

    if (!field.isEnabled) return;

    field.disable();
    setState(() {});
  }

  void enableField(String id) {
    var field = findFieldById(id);
    if (field.isEnabled) return;

    field.enable();
    setState(() {});
  }

  void setValue(String id, String value) {
    var field = findFieldById(id);

    field.setValue(value);
  }

  void setError(String id, String errorMessage) {
    var field = findFieldById(id);

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
