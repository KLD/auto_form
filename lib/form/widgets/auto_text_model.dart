import 'package:flutter/material.dart';

import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_model.dart';
import '../abstract/auto_field.dart';

class AutoTextModel extends AutoFieldModel {
  bool obscure;
  AutoTextModel({
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
  AutoField asWidget({Key? key}) => AutoTextField(model: this, key: key);
}

class AutoTextField extends AutoField<AutoTextModel> {
  AutoTextField({
    required super.model,
    super.key,
  });

  @override
  State<AutoField> createState() => AutoTextFieldState();
}

class AutoTextFieldState extends AutoFieldState<AutoTextField> {
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
