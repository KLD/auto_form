import 'package:auto_form/form/abstract/base_dynamic_field.dart';

abstract class TriggerEvent {
  const TriggerEvent();
  void apply(BaseDynamicField field);
  void reverse(BaseDynamicField field);
}

class _ReverseTriggerEventAdaptor extends TriggerEvent {
  final TriggerEvent triggerEvent;

  const _ReverseTriggerEventAdaptor(this.triggerEvent);

  @override
  void apply(BaseDynamicField field) => triggerEvent.reverse(field);

  @override
  void reverse(BaseDynamicField field) => triggerEvent.apply(field);
}

class HideEvent extends TriggerEvent {
  const HideEvent();
  @override
  void apply(BaseDynamicField field) => field.hide();

  @override
  void reverse(BaseDynamicField field) => field.show();
}

class ShowEvent extends _ReverseTriggerEventAdaptor {
  const ShowEvent() : super(const HideEvent());
}

class EnableEvent extends TriggerEvent {
  const EnableEvent();
  @override
  void apply(BaseDynamicField field) {
    field.enable();
  }

  @override
  void reverse(BaseDynamicField field) {
    field.disable();
  }
}

class DisableEvent extends _ReverseTriggerEventAdaptor {
  const DisableEvent() : super(const EnableEvent());
}

class ClearEvent extends TriggerEvent {
  @override
  void apply(BaseDynamicField field) {
    field.clear();
  }

  @override
  void reverse(BaseDynamicField field) {}
}
