import 'package:flutter/material.dart';

import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

class AutoTextField extends AutoFieldWidget {
  final bool obscure;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;

  AutoTextField({
    super.key,
    required super.id,
    required super.label,
    super.initValue,
    super.enabled,
    super.hidden,
    super.required,
    super.validations,
    super.triggers,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  State<AutoFieldWidget> createState() => AutoTextFieldState();
}

class AutoTextFieldState extends AutoFieldState<AutoTextField> {
  final TextEditingController _controller = TextEditingController();

  bool isVisibilityToggled = true;

  @override
  void initState() {
    super.initState();

    onValueSet.clear();

    onValueSet.add((value) {
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
        enabled: isEnabled,
        obscureText: widget.obscure && isVisibilityToggled,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        onChanged: (value) {
          setState(() {});
          setValue(value);
        },
        decoration: InputDecoration(
            labelText: widget.label,
            errorText: errorMessage,
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.obscure) buildVisibilityToggleIconButton(),
                if (_controller.text.isNotEmpty) buildClearIcon(),
              ],
            )),
        validator: fieldValidator);
  }

  Widget buildVisibilityToggleIconButton() {
    return IconButton(
      icon: Icon(
        isVisibilityToggled ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isVisibilityToggled = !isVisibilityToggled;
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
