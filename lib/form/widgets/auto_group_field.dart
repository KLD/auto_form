import 'dart:convert';

import 'package:auto_form/form/abstract/auto_field_widget.dart';
import 'package:flutter/material.dart';

import '../abstract/auto_field_state.dart';

class AutoGroupField extends AutoFieldWidget {
  final List<Widget> children;

  AutoGroupField({
    super.key,
    required super.id,
    required super.label,
    required this.children,
    super.hidden,
  });

  @override
  String get value {
    return jsonEncode({
      for (var c in children.whereType<AutoFieldWidget>()) c.id: c.value,
    });
  }

  @override
  void setValue(String value) {
    throw "Cannot force value here";
  }

  @override
  void refresh() {
    for (var c in children.whereType<AutoFieldWidget>()) {
      c.refresh();
    }
    super.refresh();
  }

  @override
  State<StatefulWidget> createState() => AutoGroupState();
}

class AutoGroupState extends AutoFieldState<AutoGroupField> {
  @override
  void initState() {
    super.initState();

    for (var f in widget.children.whereType<AutoFieldWidget>()) {
      f.form = widget.form;
    }
  }

  @override
  Widget buildField(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.children,
    );
  }
}
