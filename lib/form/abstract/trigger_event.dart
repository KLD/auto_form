import 'package:json_form/form/abstract/base_dynamic_field.dart';

abstract class TriggerEvent {
  void apply(BaseDynamicField field);
  void reverse(BaseDynamicField field);
}

class HideEvent extends TriggerEvent {
  @override
  void apply(BaseDynamicField field) {
    field.hide();
  }

  @override
  void reverse(BaseDynamicField field) {
    field.show();
  }
}

class ShowEvent extends TriggerEvent {
  @override
  void apply(BaseDynamicField field) {
    field.show();
  }

  @override
  void reverse(BaseDynamicField field) {
    field.hide();
  }
}

class EnableEvent extends TriggerEvent {
  @override
  void apply(BaseDynamicField field) {
    field.enable();
  }

  @override
  void reverse(BaseDynamicField field) {
    field.disable();
  }
}

class DisableEvent extends TriggerEvent {
  @override
  void apply(BaseDynamicField field) {
    field.disable();
  }

  @override
  void reverse(BaseDynamicField field) {
    field.enable();
  }
}

class ClearEvent extends TriggerEvent {
  @override
  void apply(BaseDynamicField field) {
    field.clear();
  }

  @override
  void reverse(BaseDynamicField field) {}
}
