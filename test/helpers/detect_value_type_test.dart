import 'package:auto_form/src/form/abstract/comparor.dart';
import 'package:auto_form/src/form/abstract/detect_value_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Detect string", () {
    var value = "text";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.string);
  });

  test("Detect number", () {
    var value = "123";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.number);
  });

  test("Detect nevative number ", () {
    var value = "-12";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.number);
  });

  test("Detect number with decimals ", () {
    var value = "12.5";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.number);
  });

  test("Detect duration", () {
    var value = "12:12";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.duration);
  });

  test("Detect duration with hours", () {
    var value = "10:12:12";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.duration);
  });

  test("Detect duration with days", () {
    var value = "10:10:12:12";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.duration);
  });

  test("Detect date time", () {
    var value = "2021-01-01";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.dateTime);
  });

  test("Detect date time", () {
    var value = "2021-01-01";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.dateTime);
  });

  test("Not detect date time wihout leading 0 on month and day", () {
    var value = "2021-1-1";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.string);
  });
  test("Not detect date time wihout leading 0 on day", () {
    var value = "2021-01-1";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.string);
  });
  test("Not detect date time wihout leading 0 on month", () {
    var value = "2021-1-01";

    var detectedType = detectValueType(value);

    expect(detectedType, ValueType.string);
  });
}
