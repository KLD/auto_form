import 'package:flutter/material.dart';
import 'auto_field_model.dart';
import 'field_trigger.dart';
import 'field_validation.dart';
import 'value_pointer.dart';

import '../auto_form.dart';

abstract class AutoFieldWidget extends StatefulWidget
    implements AutoFieldInterface {
  @override
  final String id;
  @override
  final String label;
  @override
  final String initValue;
  @override
  final bool enabled;
  @override
  final bool hidden;
  @override
  final bool required;
  @override
  final List<FieldValidation> validations;
  @override
  final List<FieldTrigger> triggers;

  late final AutoForm form;

  final ValuePointer<void Function()?> onRefresh = ValuePointer(null);
  final List<void Function(String)> onValueSet = [];

  final StringPointer _pointer = StringPointer("");
  final BoolPointer isHidden = BoolPointer(false);
  final BoolPointer isEnabled = BoolPointer(true);
  final BoolPointer mounted = BoolPointer(false);
  final List<void Function()> postponedTriggers = [];

  String get value => _pointer.value;

  AutoFieldWidget({
    required this.id,
    required this.label,
    this.initValue = "",
    this.enabled = true,
    this.hidden = false,
    this.required = false,
    this.validations = const [],
    this.triggers = const [],
    Key? key,
  }) : super(key: key) {
    _pointer.value = initValue;
    isHidden.value = hidden;
    isEnabled.value = enabled;
  }

  void setValue(String value) {
    _pointer.value = value;

    for (var t in triggers) {
      t.handleTrigger(form: form, value: value);
    }

    for (var e in onValueSet) {
      e(value);
    }
  }

  void clear() {
    setValue("");
  }

  void refresh() {
    onRefresh.value?.call();
  }

  void hide() {
    isHidden.value = true;
    refresh();
  }

  void show() {
    isHidden.value = false;
    refresh();
  }

  void disable() {
    isEnabled.value = false;
    refresh();
  }

  void enable() {
    isEnabled.value = true;
    refresh();
  }

  String? fieldValidator(String? value) {
    value ??= "";
    if (required && value.isEmpty) {
      return "Required Field";
    }

    if (value.isEmpty) return null;

    for (var v in validations) {
      if (v.validate(value: value, form: form)) {
        return v.errorMessage;
      }
    }

    return null;
  }
}
