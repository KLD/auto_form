import 'package:auto_form/src/form/abstract/condition.dart';
import 'package:auto_form/src/form/abstract/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("RegexValidation pass value and error message", () {
    var regexValidation = const RegexValidation(
      value: "a",
      errorMessage: "error",
    );

    expect(regexValidation.value, "a");
    expect(regexValidation.errorMessage, "error");
    expect(regexValidation.condition, isA<RegexCondition>());
  });
}
