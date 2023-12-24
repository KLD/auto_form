import 'package:flutter/material.dart';

import '../abstract/dynamic_field_model.dart';
import '../abstract/base_dynamic_field.dart';

class DropdownItem {
  final String value;
  final String Function(BuildContext) label;

  DropdownItem({
    required this.value,
    required this.label,
  });
}

class DynamicDropdownModel extends DynamicFieldModel {
  final List<DropdownItem> items;

  DynamicDropdownModel({
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
  BaseDynamicField<DynamicFieldModel> asWidget({Key? key}) =>
      DynamicDropdownField(model: this, key: key);
}

class DynamicDropdownField extends BaseDynamicField<DynamicDropdownModel> {
  DynamicDropdownField({
    required super.model,
    super.key,
  });

  @override
  State<BaseDynamicField> createState() => _DynamicDropdownFieldState();
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
