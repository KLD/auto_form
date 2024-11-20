import 'package:auto_form_plus/src/form/abstract/auto_field_widget.dart';
import 'package:flutter/material.dart';

import '../abstract/auto_field_state.dart';

class AutoGroupField extends AutoFieldWidget {
  final Widget child;
  final bool showDecorator;

  AutoGroupField({
    super.key,
    required super.id,
    required this.child,
    this.showDecorator = false,
    super.label = "",
    super.hidden,
  });

  AutoGroupField.column({
    super.key,
    required super.id,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    this.showDecorator = false,
    super.label = "",
    super.hidden,
  }) : child = Column(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children);

  AutoGroupField.row({
    super.key,
    required super.id,
    required List<Widget> children,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    this.showDecorator = false,
    super.label = "",
    super.hidden,
  }) : child = Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children);

  @override
  String get value {
    return "";
  }

  @override
  void setValue(String value) {
    throw "Cannot force value in AutoGroupField";
  }

  @override
  State<StatefulWidget> createState() => AutoGroupState();
}

class AutoGroupState extends AutoFieldState<AutoGroupField> {
  @override
  Widget buildField(BuildContext context) {
    if (widget.showDecorator) {
      return InputDecorator(
        decoration: InputDecoration(
            label: widget.label.isEmpty ? null : Text(widget.label),
            enabled: widget.enabled),
        isEmpty: false,
        child: widget.child,
      );
    }

    return widget.child;
  }
}
