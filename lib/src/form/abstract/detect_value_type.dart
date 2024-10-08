import 'comparor.dart';

const durationFormatPatern = r"^\d{1,2}(:\d{1,2}){1,3}?$";

ValueType detectValueType(String value) {
  if (DateTime.tryParse(value) != null) {
    return ValueType.dateTime;
  }
  if (num.tryParse(value) != null) {
    return ValueType.number;
  }
  if (RegExp(durationFormatPatern).hasMatch(value)) {
    return ValueType.duration;
  }

  return ValueType.string;
}
