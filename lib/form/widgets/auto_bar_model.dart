import 'package:flutter/material.dart';

import '../abstract/auto_field_model.dart';
import '../abstract/auto_field.dart';

class AutoBarModel extends AutoFieldModel {
  final Color color;
  final int progress;
  final String valueLabel;
  final String? url;
  final String? bodyFieldName;

  AutoBarModel({
    required super.id,
    required super.label,
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    super.triggers = const [],
    required this.color,
    required this.progress,
    required this.valueLabel,
    this.url,
    this.bodyFieldName = "progress",
  });

  @override
  AutoField asWidget({Key? key}) => DynamicBarField(model: this, key: key);
}

class DynamicBarField extends AutoField<AutoBarModel> {
  DynamicBarField({
    required super.model,
    super.key,
  });

  @override
  State<DynamicBarField> createState() => _DynamicBarFieldState();
}

class _DynamicBarFieldState extends State<DynamicBarField>
    with SingleTickerProviderStateMixin {
  late AnimationController barAnimationController;
  late Animation<double> barAnimation;

  int progress = 0;

  @override
  void initState() {
    progress = widget.model.progress;

    barAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    barAnimation =
        Tween<double>(begin: 10, end: widget.model.progress.toDouble()).animate(
            CurvedAnimation(
                parent: barAnimationController,
                curve: const Interval(0, 1, curve: Curves.linear)));

    barAnimationController.addListener(() => setState(() {}));
    barAnimationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Text(widget.model.label, style: const TextStyle(fontSize: 16)),
                Text(widget.model.valueLabel,
                    style: const TextStyle(fontSize: 16)),
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
                      child: ColoredBox(color: widget.model.color),
                    ),
                  ),
                  Expanded(
                    flex: 100 - barAnimation.value.toInt(),
                    child: SizedBox(
                      height: 12,
                      child: ColoredBox(
                          color: widget.model.color.withOpacity(.50)),
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
