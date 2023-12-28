import 'package:flutter/material.dart';

import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

class AutoTextField extends AutoFieldWidget {
  final bool obscure;
  AutoTextField({
    super.key,
    required super.id,
    required super.label,
    super.initValue = "",
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    super.triggers = const [],
    this.obscure = false,
  });

  @override
  State<AutoFieldWidget> createState() => AutoTextFieldState();
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
        enabled: widget.isEnabled.value,
        onChanged: widget.setValue,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        validator: widget.fieldValidator);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
