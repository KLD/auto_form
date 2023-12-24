import '../dynamic_form.dart';
import 'dynamic_comparor.dart';

abstract class ValidationOperation {
  // Comparor<dynamic>? comparor;

  bool call(String a, String b) {
    var comparor = comparors[detectValueType(b)]!;

    dynamic parsedValue = comparor.parse(a);
    dynamic parsedTargetValue = comparor.parse(b);

    return isValid(parsedValue, parsedTargetValue);
  }

  bool isValid(dynamic a, dynamic b);
}

class FieldValidation {
  final String errorMessage;
  final String targetValue;
  final ValidationOperation operation;
  FieldValidation({
    required this.errorMessage,
    required this.targetValue,
    required this.operation,
  });

  bool validate({required DynamicForm form, required String value}) {
    String targetValue = this.targetValue;
    if (targetValue.startsWith("@")) {
      var targetField = form.fields[targetValue.substring(1)];
      if (targetField == null) {
        throw "Field with id ${targetValue.substring(1)} not found";
      }
      targetValue = targetField.value;
    }

    return operation(value, targetValue);
  }
}

T? parseEnum<T extends Enum>(List<T> values, String? value, [T? fallback]) {
  if (value == null) return fallback;

  return values.cast<T?>().firstWhere(
      (e) => e!.name.toLowerCase() == value.toLowerCase(),
      orElse: () => fallback);
}

enum ValidationOperationType {
  equals,
  notEquals,
  greater,
  greaterOrEquals,
  less,
  lessOrEquals,
  match,
}

class EqualsOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return a == b;
  }
}

class NotEqualsOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return a != b;
  }
}

class GreaterOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return a > b;
  }
}

class GreaterOrEqualsOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return a >= b;
  }
}

class LessOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return a < b;
  }
}

class LessOrEqualsOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return a <= b;
  }
}

class MatchOperation extends ValidationOperation {
  @override
  bool isValid(dynamic a, dynamic b) {
    return RegExp("^$b\$").hasMatch(a);
  }
}

ValueType detectValueType(String value) {
  if (value.startsWith("@")) {
    value = value.substring(1);
  }

  if (DateTime.tryParse(value) != null) {
    return ValueType.dateTime;
  }
  if (num.tryParse(value) != null) {
    return ValueType.number;
  }
  if (RegExp(r"^\d{2}:\d{2}(:\d{2})?$").hasMatch(value)) {
    return ValueType.duration;
  }

  return ValueType.string;
}
