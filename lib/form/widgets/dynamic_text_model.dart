import 'package:flutter/material.dart';

import '../abstract/base_dynamic_field_state.dart';
import '../abstract/dynamic_field_model.dart';
import '../abstract/base_dynamic_field.dart';

class DynamicTextModel extends DynamicFieldModel {
  bool obscure;
  DynamicTextModel({
    required super.id,
    required super.label,
    super.initValue,
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    this.obscure = false,
    super.triggers = const [],
  });

  @override
  BaseDynamicField asWidget({Key? key}) =>
      DynamicTextField(model: this, key: key);
}

class DynamicTextField extends BaseDynamicField<DynamicTextModel> {
  DynamicTextField({
    required super.model,
    super.key,
  });

  @override
  State<BaseDynamicField> createState() => DynamicTextFieldState();
}

class DynamicTextFieldState extends DynamicFieldState<DynamicTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.onValueSet.add((value) {
      if (_controller.text != value) {
        _controller.text = value;
      }
    });
  }

  @override
  Widget buildField(BuildContext context) {
    return TextFormField(
        controller: _controller,
        enabled: widget.enabled.value,
        onChanged: widget.setValue,
        obscureText: widget.model.obscure,
        decoration: InputDecoration(
          labelText: widget.model.label,
        ),
        validator: widget.fieldValidator);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
