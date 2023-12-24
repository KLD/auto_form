import 'package:flutter/material.dart';

import 'abstract/base_dynamic_field.dart';

class DynamicForm extends StatefulWidget {
  final List<Widget> children;
  final void Function(Map<String, String>) onSubmit;

  final Map<String, BaseDynamicField> fields;
  final EdgeInsets padding;

  DynamicForm({
    this.children = const [],
    required this.onSubmit,
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  }) : fields = {
          for (var e in children.whereType<BaseDynamicField>()) e.model.id: e
        } {
    for (var f in fields.values) {
      f.form = this;
    }
  }

  @override
  State<DynamicForm> createState() => DynamicFormState();
}

class DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          ...widget.children,
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: submit,
            child: const Text("Submit"),
          )
        ].map((e) => Padding(padding: widget.padding, child: e)).toList(),
      ),
    );
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    List<BaseDynamicField> fields =
        widget.children.whereType<BaseDynamicField>().toList();

    Map<String, String> data = {};

    for (var f in fields) {
      data[f.model.id] = f.value;
    }

    widget.onSubmit(data);
  }

  void hideField(String id) {
    var field = widget.children
        .whereType<BaseDynamicField>()
        .firstWhere((e) => e.model.id == id);

    if (field.hidden.value) return;

    field.hide();
    setState(() {});
  }

  void showField(String id) {
    var field = widget.children
        .whereType<BaseDynamicField>()
        .firstWhere((e) => e.model.id == id);

    if (!field.hidden.value) return;

    field.show();
    setState(() {});
  }

  void disableField(String id) {
    var field = widget.children
        .whereType<BaseDynamicField>()
        .firstWhere((e) => e.model.id == id);

    if (!field.enabled.value) return;

    setState(() {
      field.disable();
    });
  }

  void enableField(String id) {
    var field = widget.children
        .whereType<BaseDynamicField>()
        .firstWhere((e) => e.model.id == id);

    if (field.enabled.value) return;

    setState(() {
      field.enable();
    });
  }
}
