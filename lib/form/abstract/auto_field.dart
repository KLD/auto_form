import 'package:flutter/material.dart';
import 'auto_field_model.dart';
import 'value_pointer.dart';

import '../auto_form.dart';

abstract class AutoField<T extends AutoFieldModel> extends StatefulWidget {
  final T model;
  late final AutoForm form;

  final ValuePointer<void Function()?> onRefresh = ValuePointer(null);
  final List<void Function(String)> onValueSet = [];

  final StringPointer _pointer = StringPointer("");
  final BoolPointer hidden = BoolPointer(false);
  final BoolPointer enabled = BoolPointer(true);
  final BoolPointer mounted = BoolPointer(false);
  final List<void Function()> postponedTriggers = [];

  String get value => _pointer.value;

  void setValue(String value) {
    _pointer.value = value;

    for (var t in model.triggers) {
      t.handleTrigger(form: form, value: value);
    }

    for (var e in onValueSet) {
      e(value);
    }
  }

  void clear() {
    setValue("");
  }

  AutoField({
    required this.model,
    super.key,
  }) {
    this.hidden.value = model.hidden;
    this.enabled.value = model.enabled;
  }

  void refresh() {
    print("Field ${model.id} being refreshed");
    this.onRefresh.value?.call();
  }

  void hide() {
    print("Field ${model.id} hiding");
    hidden.value = true;
    refresh();
  }

  void show() {
    print("Field ${model.id} showing");
    hidden.value = false;
    refresh();
  }

  void disable() {
    print("Field ${model.id} being disabled");

    enabled.value = false;
    refresh();
  }

  void enable() {
    print("Field ${model.id} being enabled");
    enabled.value = true;
    refresh();
  }

  String? fieldValidator(String? value) {
    value ??= "";
    if (model.required && value.isEmpty) {
      return "Required Field";
    }

    if (value.isEmpty) return null;

    for (var v in model.validations) {
      if (v.validate(value: value, form: form)) {
        return v.errorMessage;
      }
    }

    return null;
  }
}
