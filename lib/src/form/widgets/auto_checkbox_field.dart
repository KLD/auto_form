import 'package:auto_form_plus/src/form/abstract/auto_field_state.dart';
import 'package:flutter/material.dart';

import '../abstract/auto_field_widget.dart';

class AutoCheckboxField extends AutoFieldWidget {
  AutoCheckboxField({
    super.key,
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
  });

  @override
  State<AutoFieldWidget> createState() => _DynamicCheckboxFieldState();
}

class _DynamicCheckboxFieldState extends AutoFieldState<AutoCheckboxField> {
  @override
  void initState() {
    super.initState();

    setValue((widget.initValue == true.toString()).toString());
  }

  @override
  Widget buildField(BuildContext context) {
    return CheckboxListTile(
        value: value == true.toString(),
        title: Text(widget.label),
        enabled: isEnabled,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (v) {
          setState(() {
            setValue(v.toString());
          });
        });
  }
}
