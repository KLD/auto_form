import 'package:flutter/material.dart';

import '../abstract/dynamic_field_model.dart';
import '../abstract/base_dynamic_field.dart';

class DynamicCheckboxModel extends DynamicFieldModel {
  DynamicCheckboxModel({
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    super.triggers = const [],
  });

  @override
  BaseDynamicField asWidget({Key? key}) =>
      DynamicCheckboxField(model: this, key: key);
}

class DynamicCheckboxField extends BaseDynamicField<DynamicCheckboxModel> {
  DynamicCheckboxField({
    required super.model,
    super.key,
  });

  @override
  State<BaseDynamicField> createState() => _DynamicCheckboxFieldState();
}

class _DynamicCheckboxFieldState extends State<DynamicCheckboxField> {
  bool _value = false;

  @override
  void initState() {
    super.initState();

    widget.setValue((widget.model.initValue == true.toString()).toString());
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: widget.value == true.toString(),
        title: Text(widget.model.label),
        enabled: widget.enabled.value,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (_) {
          setState(() {
            _value = !_value;
            widget.setValue(_value.toString());
          });
        });
  }
}
