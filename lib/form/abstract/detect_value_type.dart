import 'dynamic_comparor.dart';

const durationFormatPatern = r"^\d{2}:\d{2}(:\d{2})?$";

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
  if (RegExp(durationFormatPatern).hasMatch(value)) {
    return ValueType.duration;
  }

  return ValueType.string;
}
