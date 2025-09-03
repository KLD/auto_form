import 'package:auto_form_plus/src/form/abstract/auto_field_state.dart';

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

  bool validate({required AutoFieldState field, required String value}) {
    String targetValue = field.form.resolveValue(value);

    return condition(targetValue, this.value);
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
    required super.value,
    required super.errorMessage,
  })
  // coverage:ignore-start
  : super(
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
    required super.value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          condition: const EqualsCondition(),
        );
  // coverage:ignore-end
}

class NotEqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must equal ";
  const NotEqualsValidation({
    required super.value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          condition: const NotEqualsCondition(),
        );
  // coverage:ignore-end
}

class GreaterValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be greater than ";
  const GreaterValidation({
    required super.value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          condition: const GreaterCondition(),
        );
  // coverage:ignore-end
}

class GreaterOrEqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be greater or equal than ";
  const GreaterOrEqualsValidation({
    required super.value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          condition: const GreaterOrEqualsCondition(),
        );
  // coverage:ignore-end
}

class LessValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be less than ";
  const LessValidation({
    required super.value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          condition: const LessCondition(),
        );
  // coverage:ignore-end
}

class LessOrEqualsValidation extends FieldValidation {
  static const defaultErrorMessage = "Value must be less or equal than ";
  const LessOrEqualsValidation({
    required super.value,
    String? errorMessage,
  })
  // coverage:ignore-start
  : super(
          errorMessage: errorMessage ?? defaultErrorMessage + value,
          condition: const LessOrEqualsCondition(),
        );
  // coverage:ignore-end
}
