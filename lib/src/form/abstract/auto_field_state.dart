import 'package:auto_form_plus/src/form/auto_form.dart';
import 'package:flutter/material.dart';

abstract class AutoFieldState<T extends AutoFieldWidget> extends State<T> {
  String? errorMessage;

  AutoFormState get form => context.findAncestorStateOfType<AutoFormState>()!;

  String value = "";

  bool isHidden = false;
  bool isEnabled = true;

  final List<void Function()> postponedTriggers = [];

  @override
  void initState() {
    super.initState();

    value = widget.initValue;
    isHidden = widget.hidden;
    isEnabled = widget.enabled;

    setupHooks();
  }

  void setupHooks() {
    var form = context.findAncestorStateOfType<AutoFormState>();
    if (form == null) {
      throw "No AutoForm found in widget tree";
    }
    form.registerField(this);

    // widget.onRefresh.value = () {
    //   if (mounted) {
    //     setState(() {});
    //   }
    // };

    // widget.onValueSet.add((value) {});

    // widget.setErrorPointer.value = (message) {
    //   setState(() {
    //     errorMessage = message;
    //   });
    // };

    // if (widget.initValue.isNotEmpty) {
    //   widget.setValue(widget.initValue);
    // }

    if (postponedTriggers.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (var t in postponedTriggers) {
          t();
        }
        postponedTriggers.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isHidden) return const SizedBox();
    return buildField(context);
  }

  Widget buildField(BuildContext context);

  Widget buildClearIcon() {
    return IconButton(
        onPressed: clear, icon: const Icon(Icons.close, size: 16));
  }

  void setValue(String newValue) {
    this.value = newValue;

    for (var t in widget.triggers) {
      t.handleTrigger(field: this, fieldValue: newValue);
    }

    for (var e in onValueSet) {
      e(newValue);
    }
  }

  List<void Function(String)> onValueSet = [];

  void setError(String? errorMessage) {
    setState(() {
      this.errorMessage = errorMessage;
    });
  }

  void clearError() {
    setError(null);
  }

  void clearValue() {
    setValue("");
  }

  void clear() {
    clearError();
    clearValue();
  }

  void refresh() {
    setState(() {});
  }

  void hide() {
    isHidden = true;
    refresh();
  }

  void show() {
    isHidden = false;
    refresh();
  }

  void disable() {
    isEnabled = false;
    refresh();
  }

  void enable() {
    isEnabled = true;
    refresh();
  }

  String? fieldValidator(String? value) {
    value ??= "";

    List<String> errors = [];

    for (var v in widget.validations) {
      if (v.validate(value: value, field: this)) {
        errors.add(v.errorMessage);
      }
    }

    return errors.isEmpty
        ? null
        : errors.length == 1
            ? errors.first
            : errors.map((e) => "- $e").join("\n");
  }
}
