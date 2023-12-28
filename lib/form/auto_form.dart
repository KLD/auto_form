import 'package:flutter/material.dart';

import 'abstract/auto_field.dart';

class AutoForm extends StatefulWidget {
  final List<Widget> children;
  final void Function(Map<String, String>) onSubmit;

  final Map<String, AutoField> fields;
  final EdgeInsets padding;

  AutoForm({
    this.children = const [],
    required this.onSubmit,
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  }) : fields = {for (var e in children.whereType<AutoField>()) e.model.id: e} {
    for (var f in fields.values) {
      f.form = this;
    }
  }

  @override
  State<AutoForm> createState() => AutoFormState();
}

class AutoFormState extends State<AutoForm> {
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

    List<AutoField> fields = widget.children.whereType<AutoField>().toList();

    Map<String, String> data = {};

    for (var f in fields) {
      data[f.model.id] = f.value;
    }

    widget.onSubmit(data);
  }

  void hideField(String id) {
    var field = widget.children
        .whereType<AutoField>()
        .firstWhere((e) => e.model.id == id);

    if (field.hidden.value) return;

    field.hide();
    setState(() {});
  }

  void showField(String id) {
    var field = widget.children
        .whereType<AutoField>()
        .firstWhere((e) => e.model.id == id);

    if (!field.hidden.value) return;

    field.show();
    setState(() {});
  }

  void disableField(String id) {
    var field = widget.children
        .whereType<AutoField>()
        .firstWhere((e) => e.model.id == id);

    if (!field.enabled.value) return;

    setState(() {
      field.disable();
    });
  }

  void enableField(String id) {
    var field = widget.children
        .whereType<AutoField>()
        .firstWhere((e) => e.model.id == id);

    if (field.enabled.value) return;

    setState(() {
      field.enable();
    });
  }
}
