import 'package:auto_form/form/abstract/auto_field_widget.dart';

abstract class TriggerEvent {
  const TriggerEvent();
  void apply(AutoFieldWidget field);
  void reverse(AutoFieldWidget field);
}

class _ReverseTriggerEventAdaptor extends TriggerEvent {
  final TriggerEvent triggerEvent;

  const _ReverseTriggerEventAdaptor(this.triggerEvent);

  @override
  void apply(AutoFieldWidget field) => triggerEvent.reverse(field);

  @override
  void reverse(AutoFieldWidget field) => triggerEvent.apply(field);
}

class HideEvent extends TriggerEvent {
  const HideEvent();
  @override
  void apply(AutoFieldWidget field) => field.hide();

  @override
  void reverse(AutoFieldWidget field) => field.show();
}

class ShowEvent extends _ReverseTriggerEventAdaptor {
  const ShowEvent() : super(const HideEvent());
}

class EnableEvent extends TriggerEvent {
  const EnableEvent();
  @override
  void apply(AutoFieldWidget field) {
    field.enable();
  }

  @override
  void reverse(AutoFieldWidget field) {
    field.disable();
  }
}

class DisableEvent extends _ReverseTriggerEventAdaptor {
  const DisableEvent() : super(const EnableEvent());
}

class ClearEvent extends TriggerEvent {
  @override
  void apply(AutoFieldWidget field) {
    field.clear();
  }

  @override
  void reverse(AutoFieldWidget field) {}
}
