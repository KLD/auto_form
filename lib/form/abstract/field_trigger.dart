import '../auto_form.dart';
import 'condition.dart';
import 'trigger_event.dart';

class FieldTrigger {
  final String fieldId;
  final Condition condition;

  final TriggerEvent event;
  final String value;

  const FieldTrigger({
    required this.fieldId,
    required this.value,
    required this.condition,
    required this.event,
  });

  void handleTrigger({required AutoForm form, required String value}) {
    String targetValue = this.value;
    if (targetValue.startsWith("@")) {
      var targetField = form.fields[targetValue.substring(1)];
      if (targetField == null) {
        throw "Field with id ${targetValue.substring(1)} not found";
      }
      targetValue = targetField.value;
    }
    var result = condition(value, targetValue);

    var targetField = form.fields[fieldId]!;
    if (result) {
      event.apply(targetField);
    } else {
      event.reverse(targetField);
    }
  }
}
