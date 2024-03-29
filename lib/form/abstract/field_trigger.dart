import 'auto_field_widget.dart';
import 'condition.dart';
import 'trigger_event.dart';

class FieldTrigger {
  /// Target value to test condition with field value. Prefix with `@` to refrence another field
  final String value;

  /// Condition to test value and field value
  final Condition condition;

  /// Target field to trigger event on
  final String? fieldId;

  /// Event to be triggered when condition is true
  final TriggerEvent event;

  const FieldTrigger.other({
    required String this.fieldId,
    required this.value,
    required this.condition,
    required this.event,
  });

  const FieldTrigger.self({
    required this.value,
    required this.condition,
    required this.event,
  }) : fieldId = null;

  /// Testers condition given target value with field value. Applies or reverses trigger based on result.
  void handleTrigger(
      {required AutoFieldWidget field, required String fieldValue}) {
    String targetValue = field.form.resolveValue(value);

    var result = condition(fieldValue, targetValue);
    var targetField = fieldId == null ? field : field.form.fields[fieldId]!;

    if (targetField.mounted.value) {
      _handleEvent(result, event, targetField);
    } else {
      targetField.postponedTriggers
          .add(() => _handleEvent(result, event, targetField));
    }
  }

  void _handleEvent(
      bool result, TriggerEvent event, AutoFieldWidget targetField) {
    if (result) {
      event.apply(targetField);
    } else {
      event.reverse(targetField);
    }
  }
}
