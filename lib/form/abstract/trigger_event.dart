import 'package:auto_form/form/abstract/auto_field.dart';

abstract class TriggerEvent {
  const TriggerEvent();
  void apply(AutoField field);
  void reverse(AutoField field);
}

class _ReverseTriggerEventAdaptor extends TriggerEvent {
  final TriggerEvent triggerEvent;

  const _ReverseTriggerEventAdaptor(this.triggerEvent);

  @override
  void apply(AutoField field) => triggerEvent.reverse(field);

  @override
  void reverse(AutoField field) => triggerEvent.apply(field);
}

class HideEvent extends TriggerEvent {
  const HideEvent();
  @override
  void apply(AutoField field) => field.hide();

  @override
  void reverse(AutoField field) => field.show();
}

class ShowEvent extends _ReverseTriggerEventAdaptor {
  const ShowEvent() : super(const HideEvent());
}

class EnableEvent extends TriggerEvent {
  const EnableEvent();
  @override
  void apply(AutoField field) {
    field.enable();
  }

  @override
  void reverse(AutoField field) {
    field.disable();
  }
}

class DisableEvent extends _ReverseTriggerEventAdaptor {
  const DisableEvent() : super(const EnableEvent());
}

class ClearEvent extends TriggerEvent {
  @override
  void apply(AutoField field) {
    field.clear();
  }

  @override
  void reverse(AutoField field) {}
}
