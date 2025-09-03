import 'package:auto_form_plus/src/form/abstract/auto_field_state.dart';
import 'package:flutter/material.dart';

import '../abstract/auto_field_widget.dart';

class AutoBarField extends AutoFieldWidget {
  final Color color;
  final String valueLabel;
  final String? url;
  final String? bodyFieldName;

  AutoBarField({
    super.key,
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    required this.color,
    required super.initValue,
    required this.valueLabel,
    this.url,
    this.bodyFieldName = "progress",
  });

  @override
  State<AutoBarField> createState() => _DynamicBarFieldState();
}

class _DynamicBarFieldState extends AutoFieldState<AutoBarField>
    with SingleTickerProviderStateMixin {
  late AnimationController barAnimationController;
  late Animation<double> barAnimation;

  @override
  void initState() {
    super.initState();

    var initProgress = int.tryParse(widget.initValue);
    initProgress ??= 0;

    setValue(initProgress.toString());
    barAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    barAnimation = Tween<double>(begin: 10, end: initProgress.toDouble())
        .animate(CurvedAnimation(
            parent: barAnimationController,
            curve: const Interval(0, 1, curve: Curves.linear)));

    barAnimationController.addListener(() => setState(() {}));
    barAnimationController.forward();
    super.initState();
  }

  @override
  Widget buildField(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InputDecorator(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            label: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.label, style: const TextStyle(fontSize: 16)),
                Text(widget.valueLabel, style: const TextStyle(fontSize: 16)),
              ],
            ),
            filled: false,
          ),
          child: SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(900),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: barAnimation.value.toInt(),
                    child: SizedBox(
                      height: 12,
                      child: ColoredBox(color: widget.color),
                    ),
                  ),
                  Expanded(
                    flex: 100 - barAnimation.value.toInt(),
                    child: SizedBox(
                      height: 12,
                      child: ColoredBox(
                          color: widget.color.withValues(alpha: .50)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    barAnimationController.dispose();
    super.dispose();
  }
}
