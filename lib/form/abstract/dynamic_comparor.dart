enum ValueType {
  string,
  dateTime,
  duration,
  number,
}

abstract class Comparor<T> {
  const Comparor();

  T parse(String str);

  bool equal(T a, T b);

  int compare(T a, T b);

  T add(T a, T b);

  T subtract(T a, T b);

  T multiply(T a, T b);

  T divide(T a, T b);
}

const comparors = <ValueType, Comparor>{
  ValueType.string: stringComparor,
  ValueType.dateTime: dateTimeComparor,
  ValueType.number: numberComparor,
  ValueType.duration: durationComparor,
};

const stringComparor = StringComparor();

class StringComparor extends Comparor<String> {
  const StringComparor();
  @override
  bool equal(String a, String b) => a == b;

  @override
  int compare(String a, String b) => a.compareTo(b);

  @override
  String parse(String str) => str;

  @override
  String add(String a, String b) => a + b;

  @override
  String subtract(String a, String b) => throw "Cannot subtract strings";

  @override
  String multiply(String a, String b) => throw "Cannot multiply strings";

  @override
  String divide(String a, String b) => throw "Cannot divide strings";
}

const numberComparor = NumberComparor();

class NumberComparor extends Comparor<double> {
  const NumberComparor();
  @override
  bool equal(double a, double b) => a == b;

  @override
  int compare(double a, double b) => a.compareTo(b);

  @override
  double parse(String str) => double.parse(str);

  @override
  double add(double a, double b) => a + b;

  @override
  double subtract(double a, double b) => a - b;

  @override
  double multiply(double a, double b) => a * b;

  @override
  double divide(double a, double b) => a / b;
}

const dateTimeComparor = DateTimeComparor();

class DateTimeComparor extends Comparor<DateTime> {
  const DateTimeComparor();
  @override
  bool equal(DateTime a, DateTime b) => a == b;

  @override
  int compare(DateTime a, DateTime b) => a.compareTo(b);

  @override
  DateTime parse(String str) => DateTime.parse(str);

  @override
  DateTime add(DateTime a, DateTime b) => throw "Cannot add dates";

  @override
  DateTime divide(DateTime a, DateTime b) => throw "Cannot divide dates";

  @override
  DateTime multiply(DateTime a, DateTime b) => throw "Cannot multiply dates";

  @override
  DateTime subtract(DateTime a, DateTime b) => throw "Cannot subtract dates";
}

const durationComparor = DurationComparor();

class DurationComparor extends Comparor<Duration> {
  const DurationComparor();
  @override
  bool equal(Duration a, Duration b) => a == b;

  @override
  int compare(Duration a, Duration b) => a.compareTo(b);

  @override
  Duration parse(String str) {
    var tokens = str.split(':');

    Duration d = const Duration();

    if (tokens.length == 3) {
      d += Duration(hours: int.parse(tokens[0]));
      d += Duration(minutes: int.parse(tokens[1]));
      d += Duration(seconds: int.parse(tokens[2]));
    } else if (tokens.length == 2) {
      d += Duration(hours: int.parse(tokens[0]));
      d += Duration(minutes: int.parse(tokens[1]));
    } else if (tokens.length == 1) {
      d += Duration(hours: int.parse(tokens[0]));
    }

    return d;
  }

  @override
  Duration add(Duration a, Duration b) => a + b;

  @override
  Duration divide(Duration a, Duration b) => throw "Cannot devide durations";

  @override
  Duration multiply(Duration a, Duration b) =>
      throw "Cannot multiply durations";

  @override
  Duration subtract(Duration a, Duration b) => a - b;
}
