import 'package:flutter/material.dart';

import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

class DropdownItem {
  final String value;
  final String label;

  DropdownItem({
    required this.value,
    String? label,
  }) : label = label ?? value;
}

class AutoDropdownField extends AutoFieldWidget {
  final List<DropdownItem> items;
  AutoDropdownField({
    super.key,
    required super.id,
    required super.label,
    required this.items,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  State<StatefulWidget> createState() => AutoDropdownState();
}

class AutoDropdownState extends AutoFieldState<AutoDropdownField> {
  @override
  void initState() {
    super.initState();

    widget.onValueSet.add((value) {
      setState(() {});
    });
  }

  @override
  Widget buildField(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.value.isEmpty ? null : widget.value,
      items: widget.items
          .map((e) => DropdownMenuItem(value: e.value, child: Text(e.label)))
          .toList(),
      onChanged: (value) {
        widget.setValue(value!);
      },
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.value.isEmpty ? null : buildClearIcon(),
      ),
      isExpanded: true,
      validator: widget.fieldValidator,
    );
  }
}
