class ValuePointer<T> {
  T value;

  ValuePointer(this.value);
}

class StringPointer extends ValuePointer<String> {
  StringPointer(super.value);
}

class BoolPointer extends ValuePointer<bool> {
  BoolPointer(super.value);
}
