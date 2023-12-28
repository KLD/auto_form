import 'package:flutter/material.dart';
import '../widgets/auto_text_field.dart';

abstract class AutoFieldState<T extends AutoTextField> extends State<T> {
  @override
  void initState() {
    super.initState();

    widget.onRefresh.value = () {
      setState(() {});
    };

    widget.onValueSet.add((value) {
      widget.refresh();
    });

    if (widget.initValue.isNotEmpty) {
      widget.setValue(widget.initValue);
    }

    if (widget.postponedTriggers.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (var t in widget.postponedTriggers) {
          t();
        }
        widget.postponedTriggers.clear();
      });
    }

    widget.mounted.value = true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHidden.value) return const SizedBox();
    return buildField(context);
  }

  Widget buildField(BuildContext context);

  @override
  void dispose() {
    widget.mounted.value = false;
    super.dispose();
  }
}
