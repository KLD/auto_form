import 'package:flutter/material.dart';

import '../abstract/auto_field_model.dart';
import '../abstract/auto_field.dart';

class DropdownItem {
  final String value;
  final String Function(BuildContext) label;

  DropdownItem({
    required this.value,
    required this.label,
  });
}

class AutoDropdownModel extends AutoFieldModel {
  final List<DropdownItem> items;

  AutoDropdownModel({
    required super.id,
    required super.label,
    required this.items,
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  AutoField<AutoFieldModel> asWidget({Key? key}) =>
      DynamicDropdownField(model: this, key: key);
}

class DynamicDropdownField extends AutoField<AutoDropdownModel> {
  DynamicDropdownField({
    required super.model,
    super.key,
  });

  @override
  State<AutoField> createState() => _DynamicDropdownFieldState();
}

class _DynamicDropdownFieldState extends State<DynamicDropdownField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.model.initValue.isNotEmpty) {
      selectedValue = widget.model.initValue;
      widget.setValue(selectedValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: widget.model.items
          .map((e) =>
              DropdownMenuItem(value: e.value, child: Text(e.label(context))))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
          widget.setValue(value!);
        });
      },
      decoration: InputDecoration(
        labelText: widget.model.label,
      ),
      isExpanded: true,
      validator: widget.fieldValidator,
    );
  }
}
