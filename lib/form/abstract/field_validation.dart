import '../dynamic_form.dart';
import 'condition.dart';

class FieldValidation {
  final String errorMessage;

  /// Value to be tested on. If it stats with @ then it will be considered as a field id
  final String value;

  final Condition condition;

  const FieldValidation({
    required this.errorMessage,
    required this.value,
    required this.condition,
  });

  bool validate({required DynamicForm form, required String value}) {
    String targetValue = this.value;
    if (targetValue.startsWith("@")) {
      var targetField = form.fields[targetValue.substring(1)];
      if (targetField == null) {
        throw "Field with id ${targetValue.substring(1)} not found";
      }
      targetValue = targetField.value;
    }

    return condition(value, targetValue);
  }
}

T? parseEnum<T extends Enum>(List<T> values, String? value, [T? fallback]) {
  if (value == null) return fallback;

  return values.cast<T?>().firstWhere(
      (e) => e!.name.toLowerCase() == value.toLowerCase(),
      orElse: () => fallback);
}
