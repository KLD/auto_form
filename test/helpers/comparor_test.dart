import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/abstract/dynamic_comparor.dart';

void main() {
  group("String comparor", () {
    const stringComparor = StringComparor();
    test("""WHEN comparing identical
  SHOULD equals""", () {
      expect(stringComparor.equal("a", "a"), true);
    });
    test("""WHEN comparing different
  SHOULD not equal""", () {
      expect(stringComparor.equal("A", "a"), false);
    });
    test("""WHEN comparing different
  SHOULD not equal""", () {
      expect(stringComparor.equal("a", "b"), false);
    });
    test("""WHEN add
  SHOULD concatenate""", () {
      expect(stringComparor.add("a", "a"), "aa");
    });
    test("""WHEN subtract
  SHOULD throw exception""", () {
      expect(() => stringComparor.subtract("a", "a"), throwsA(isA<String>()));
    });
    test("""WHEN multiply
  SHOULD throw exception""", () {
      expect(() => stringComparor.multiply("a", "a"), throwsA(isA<String>()));
    });
    test("""WHEN divide
  SHOULD throw exception""", () {
      expect(() => stringComparor.divide("a", "a"), throwsA(isA<String>()));
    });
  });

  group("Number comparor", () {
    const numberComparor = NumberComparor();
    test("""WHEN comparing identical
  SHOULD equals""", () {
      expect(numberComparor.equal(1, 1), true);
    });
    test("""WHEN comparing different
  SHOULD not equal""", () {
      expect(numberComparor.equal(1, 2), false);
    });
    test("""WHEN comparing different
  SHOULD not equal""", () {
      expect(numberComparor.equal(2, 1), false);
    });
    test("""WHEN add
  SHOULD sum""", () {
      expect(numberComparor.add(1, 2), 3);
    });
    test("""WHEN subtract
  SHOULD subtract""", () {
      expect(numberComparor.subtract(3, 2), 1);
    });
    test("""WHEN multiply
  SHOULD multiply""", () {
      expect(numberComparor.multiply(2, 3), 6);
    });
    test("""WHEN divide
  SHOULD divide""", () {
      expect(numberComparor.divide(6, 2), 3);
    });
  });

  group("DateTime comparor", () {
    const dateTimeComparor = DateTimeComparor();
    test("""WHEN comparing identical
  SHOULD equals""", () {
      final dateTime1 = DateTime(2022, 1, 1);
      final dateTime2 = DateTime(2022, 1, 1);
      expect(dateTimeComparor.equal(dateTime1, dateTime2), true);
    });
    test("""WHEN comparing different
  SHOULD not equal""", () {
      final dateTime1 = DateTime(2022, 1, 1);
      final dateTime2 = DateTime(2022, 1, 2);
      expect(dateTimeComparor.equal(dateTime1, dateTime2), false);
    });
    test("""WHEN comparing different
  SHOULD not equal""", () {
      final dateTime1 = DateTime(2022, 1, 1);
      final dateTime2 = DateTime(2022, 2, 1);
      expect(dateTimeComparor.equal(dateTime1, dateTime2), false);
    });
    test("""WHEN add
  SHOULD throw exception""", () {
      final dateTime = DateTime(2022, 1, 1);
      expect(() => dateTimeComparor.add(dateTime, dateTime),
          throwsA(isA<String>()));
    });
    test("""WHEN subtract
  SHOULD throw exception""", () {
      final dateTime = DateTime(2022, 1, 1);
      expect(() => dateTimeComparor.subtract(dateTime, dateTime),
          throwsA(isA<String>()));
    });
    test("""WHEN multiply
  SHOULD throw exception""", () {
      final dateTime = DateTime(2022, 1, 1);
      expect(() => dateTimeComparor.multiply(dateTime, dateTime),
          throwsA(isA<String>()));
    });
    test("""WHEN divide
  SHOULD throw exception""", () {
      final dateTime = DateTime(2022, 1, 1);
      expect(() => dateTimeComparor.divide(dateTime, dateTime),
          throwsA(isA<String>()));
    });
  });

  group("Duration comparor", () {
    const durationComparor = DurationComparor();

    test("""WHEN comparing identical
  SHOULD equals""", () {
      const duration1 = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      const duration2 = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      expect(durationComparor.equal(duration1, duration2), true);
    });

    test("""WHEN comparing different
  SHOULD not equal""", () {
      const duration1 = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      const duration2 = Duration(days: 1, hours: 2, minutes: 3, seconds: 5);
      expect(durationComparor.equal(duration1, duration2), false);
    });

    test("""WHEN comparing different
  SHOULD not equal""", () {
      const duration1 = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      const duration2 = Duration(days: 1, hours: 2, minutes: 4, seconds: 4);
      expect(durationComparor.equal(duration1, duration2), false);
    });

    test("""WHEN adding durations
  SHOULD return the sum""", () {
      const duration1 = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      const duration2 = Duration(hours: 5, minutes: 6, seconds: 7);
      const expectedSum = Duration(days: 1, hours: 7, minutes: 9, seconds: 11);
      expect(durationComparor.add(duration1, duration2), expectedSum);
    });

    test("""WHEN subtracting durations
  SHOULD return the difference""", () {
      const duration1 = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      const duration2 = Duration(hours: 5, minutes: 6, seconds: 7);
      const expectedDifference =
          Duration(days: 0, hours: 20, minutes: 56, seconds: 57);
      expect(
          durationComparor.subtract(duration1, duration2), expectedDifference);
    });

    test("""WHEN multiplying duration by a scalar
  SHOULD return the scaled duration""", () {
      const duration = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);

      expect(() => durationComparor.multiply(duration, duration),
          throwsA(isA<String>()));
    });

    test("""WHEN dividing duration by a scalar
  SHOULD return the divided duration""", () {
      const duration = Duration(days: 4, hours: 8, minutes: 12, seconds: 16);

      expect(() => durationComparor.divide(duration, duration),
          throwsA(isA<String>()));
    });
  });
}
