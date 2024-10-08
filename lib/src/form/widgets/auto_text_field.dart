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

    widget.onValueSet.clear();

    widget.onValueSet.add((value) {
      if (_controller.text != value) {
        _controller.text = value;
        setState(() {});
      }
    });
  }

  @override
  Widget buildField(BuildContext context) {
    return TextFormField(
        controller: _controller,
        enabled: widget.isEnabled.value,
        onChanged: (value) {
          setState(() {});
          widget.setValue(value);
        },
        obscureText: widget.obscure,
        decoration: InputDecoration(
          labelText: widget.label,
          errorText: errorMessage,
          suffix: _controller.text.isEmpty ? null : buildClearIcon(),
        ),
        validator: widget.fieldValidator);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
