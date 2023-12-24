import 'package:flutter/material.dart';
import '../widgets/dynamic_text_model.dart';

abstract class DynamicFieldState<T extends DynamicTextField> extends State<T> {
  @override
  void initState() {
    super.initState();

    widget.onRefresh.value = () {
      setState(() {});
    };

    widget.onValueSet.add((value) {
      widget.refresh();
    });

    if (widget.model.initValue.isNotEmpty) {
      widget.setValue(widget.model.initValue);
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
    print("Building field ${widget.model.id}");
    if (widget.hidden.value) return const SizedBox();
    return buildField(context);
  }

  Widget buildField(BuildContext context);

  @override
  void dispose() {
    widget.mounted.value = false;
    super.dispose();
  }
}
