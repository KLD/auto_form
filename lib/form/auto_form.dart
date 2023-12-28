import 'package:flutter/material.dart';

import 'abstract/auto_field_widget.dart';

class AutoForm extends StatefulWidget {
  final List<Widget> children;
  final void Function(Map<String, String>) onSubmit;

  final Map<String, AutoFieldWidget> fields;
  final EdgeInsets padding;

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
}
