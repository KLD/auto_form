import 'package:flutter/material.dart';

import 'base_dynamic_field.dart';
import 'field_trigger.dart';
import 'field_validation.dart';

abstract class DynamicFieldModel {
  final String id;
  final String label;
  final String initValue;
  final bool enabled;
  final bool hidden;
  final bool required;
  final List<FieldValidation> validations;
  final List<FieldTrigger> triggers;

  DynamicFieldModel({
    required this.id,
    this.initValue = "",
    required this.label,
    required this.enabled,
    required this.hidden,
    required this.required,
    required this.validations,
    required this.triggers,
  });

  BaseDynamicField asWidget({Key? key});
}
