import 'auto_field_widget.dart';
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

  bool validate({required AutoFieldWidget field, required String value}) {
    String targetValue = field.form.resolveValue(value);

    return condition(value, targetValue);
  }
}

class RegexValidation extends FieldValidation {
  const RegexValidation({
    required super.value,
    required super.errorMessage,
  })
  // coverage:ignore-start
  : super(
          condition: const RegexCondition(),
        );
  // coverage:ignore-end

  const RegexValidation.reverse({
    required String value,
    required String errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage,
          value: value,
          condition: const NotRegexCondition(),
        );
  // coverage:ignore-end
}

class RequiredValidation extends FieldValidation {
  static const defaultErrorMessage = "Value is required";
  const RequiredValidation({
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          value: "",
          errorMessage: errorMessage ?? defaultErrorMessage,
          condition: const RequiredCondition(),
        );
  // coverage:ignore-end
}

class EqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must not equal ";
  const EqualsValidation({
    required String value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          value: value,
          condition: const EqualsCondition(),
        );
  // coverage:ignore-end
}

class NotEqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must equal ";
  const NotEqualsValidation({
    required String value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          value: value,
          condition: const NotEqualsCondition(),
        );
  // coverage:ignore-end
}

class GreaterValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be greater than ";
  const GreaterValidation({
    required String value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          value: value,
          condition: const GreaterCondition(),
        );
  // coverage:ignore-end
}

class GreaterOrEqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be greater or equal than ";
  const GreaterOrEqualsValidation({
    required String value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          value: value,
          condition: const GreaterOrEqualsCondition(),
        );
  // coverage:ignore-end
}

class LessValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be less than ";
  const LessValidation({
    required String value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          value: value,
          condition: const LessCondition(),
        );
  // coverage:ignore-end
}

class LessOrEqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be less or equal than ";
  const LessOrEqualsValidation({
    required String value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          value: value,
          condition: const LessOrEqualsCondition(),
        );
  // coverage:ignore-end
}
