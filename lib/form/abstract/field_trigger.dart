import '../dynamic_form.dart';
import 'field_validation.dart';
import 'trigger_event.dart';

class FieldTrigger {
  final String fieldId;
  final ValidationOperation operation;

  final TriggerEvent event;
  final String value;

  FieldTrigger({
    required this.fieldId,
    required this.value,
    required this.operation,
    required this.event,
  });

  void handleTrigger({required DynamicForm form, required String value}) {
    String targetValue = this.value;
    if (targetValue.startsWith("@")) {
      var targetField = form.fields[targetValue.substring(1)];
      if (targetField == null) {
        throw "Field with id ${targetValue.substring(1)} not found";
      }
      targetValue = targetField.value;
    }
    var result = operation(value, targetValue);

    var targetField = form.fields[fieldId]!;
    if (result) {
      event.apply(targetField);
    } else {
      event.reverse(targetField);
    }
  }
}
