import 'package:auto_form/src/form/abstract/auto_field_state.dart';
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

    widget.setValue((widget.initValue == true.toString()).toString());
  }

  @override
  Widget buildField(BuildContext context) {
    return CheckboxListTile(
        value: widget.value == true.toString(),
        title: Text(widget.label),
        enabled: widget.isEnabled.value,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (_) {
          setState(() {
            widget.setValue(_.toString());
          });
        });
  }
}
