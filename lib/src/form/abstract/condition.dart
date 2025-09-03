import 'comparor.dart';
import 'detect_value_type.dart';

abstract class Condition {
  final Comparor? comparorOverride;

  const Condition({Comparor<dynamic>? comparor}) : comparorOverride = comparor;

  bool call(String fieldValue, String targetValue) {
    var valueTypeA = detectValueType(fieldValue);
    var valueTypeB = detectValueType(targetValue);
    var valueType = cascadeValueType(valueTypeA, valueTypeB);

    var comparor = comparorOverride ?? defaultComparors[valueType]!;
    dynamic parsedValue = comparor.parse(fieldValue);
    dynamic parsedTargetValue = comparor.parse(targetValue);

    return isValid(parsedValue, parsedTargetValue, comparor);
  }

  bool isValid<T>(dynamic a, dynamic b, Comparor<T> comparor);
}

ValueType cascadeValueType(ValueType a, ValueType b) {
  if (a == b) {
    return a;
  }

  return ValueType.string;
}

class _ReverseConditionAdaptor extends Condition {
  final Condition condition;

  const _ReverseConditionAdaptor(this.condition);

  @override
  bool isValid<T>(a, b, c) => !condition.isValid<T>(a, b, c);
}

class EqualsCondition extends Condition {
  const EqualsCondition();

  @override
  bool isValid<T>(a, b, comparor) => comparor.equal(a, b);
}

class NotEqualsCondition extends _ReverseConditionAdaptor {
  const NotEqualsCondition() : super(const EqualsCondition());
}

class GreaterCondition extends Condition {
  const GreaterCondition();
  @override
  bool isValid<T>(dynamic a, dynamic b, comparor) => comparor.compare(a, b) > 0;
}

class GreaterOrEqualsCondition extends Condition {
  const GreaterOrEqualsCondition();
  @override
  bool isValid<T>(dynamic a, dynamic b, comparor) =>
      comparor.compare(a, b) >= 0;
}

class LessCondition extends _ReverseConditionAdaptor {
  const LessCondition() : super(const GreaterOrEqualsCondition());
}

class LessOrEqualsCondition extends _ReverseConditionAdaptor {
  const LessOrEqualsCondition() : super(const GreaterCondition());
}

class RegexCondition extends Condition {
  const RegexCondition() : super(comparor: const StringComparor());
  @override
  bool isValid<T>(dynamic a, dynamic b, comparor) {
    return RegExp("^$b\$").hasMatch(a);
  }
}

class NotRegexCondition extends _ReverseConditionAdaptor {
  const NotRegexCondition() : super(const RegexCondition());
}

class RequiredCondition extends Condition {
  const RequiredCondition() : super(comparor: const StringComparor());
  @override
  bool isValid<T>(dynamic a, dynamic b, comparor) {
    return a == null || a.toString().isEmpty;
  }
}
