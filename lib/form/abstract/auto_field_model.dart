import 'field_trigger.dart';
import 'field_validation.dart';

abstract class AutoFieldInterface {
  final String id;
  final String label;
  final String initValue;
  final bool enabled;
  final bool hidden;
  final bool required;
  final List<FieldValidation> validations;
  final List<FieldTrigger> triggers;

  AutoFieldInterface({
    required this.id,
    this.initValue = "",
    required this.label,
    required this.enabled,
    required this.hidden,
    required this.required,
    required this.validations,
    required this.triggers,
  });
}
