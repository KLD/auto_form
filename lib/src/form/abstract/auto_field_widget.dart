import 'package:flutter/material.dart';

import '../auto_form.dart';
import 'value_pointer.dart';

abstract class AutoFieldWidget extends StatefulWidget {
  final String id;
  final String label;
  final String initValue;
  final bool enabled;
  final bool hidden;
  final bool required;
  final List<FieldValidation> validations;
  final List<FieldTrigger> triggers;

  AutoForm get form => formPointer.value!;

  final ValuePointer<AutoForm?> formPointer = ValuePointer<AutoForm?>(null);

  final ValuePointer<void Function()?> onRefresh = ValuePointer(null);
  final List<void Function(String)> onValueSet = [];
  final ValuePointer<void Function(String?)> setErrorPointer =
      ValuePointer((_) {});

  final StringPointer valuePointer = StringPointer("");
  final BoolPointer isHidden = BoolPointer(false);
  final BoolPointer isEnabled = BoolPointer(true);
  final BoolPointer mounted = BoolPointer(false);
  final List<void Function()> postponedTriggers = [];

  String get value => valuePointer.value;

  AutoFieldWidget({
    required this.id,
    required this.label,
    this.initValue = "",
    this.enabled = true,
    this.hidden = false,
    this.required = false,
    List<FieldValidation>? validations,
    this.triggers = const [],
    super.key,
  }) : validations = validations ?? [] {
    assert(this.validations.where((e) => e.value == "@$id").isEmpty,
        "Field validation cannot refrence itself");
    assert(triggers.where((e) => e.fieldId == id).isEmpty,
        "Triggers cannot refrence itself");

    valuePointer.value = initValue;
    isHidden.value = hidden;
    isEnabled.value = enabled;

    if (required) {
      this.validations.insert(0, RequiredValidation());
    }
  }

  void setValue(String value) {
    valuePointer.value = value;

    for (var t in triggers) {
      t.handleTrigger(field: this, fieldValue: value);
    }

    for (var e in onValueSet) {
      e(value);
    }
  }

  void setError(String? errorMessage) {
    setErrorPointer.value(errorMessage);
  }

  void clearError() {
    setErrorPointer.value(null);
  }

  void clearValue() {
    setValue("");
  }

  void clear() {
    clearError();
    clearValue();
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

    List<String> errors = [];

    for (var v in validations) {
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
