import 'package:auto_form_plus/src/form/abstract/auto_field_state.dart';

abstract class TriggerEvent {
  const TriggerEvent();
  void apply(AutoFieldState field);
  void reverse(AutoFieldState field);
}

class _ReverseTriggerEventAdaptor extends TriggerEvent {
  final TriggerEvent triggerEvent;

  const _ReverseTriggerEventAdaptor(this.triggerEvent);

  @override
  void apply(AutoFieldState field) => triggerEvent.reverse(field);

  @override
  void reverse(AutoFieldState field) => triggerEvent.apply(field);
}

class HideEvent extends TriggerEvent {
  const HideEvent();
  @override
  void apply(AutoFieldState field) => field.hide();

  @override
  void reverse(AutoFieldState field) => field.show();
}

class ShowEvent extends _ReverseTriggerEventAdaptor {
  const ShowEvent() : super(const HideEvent());
}

class EnableEvent extends TriggerEvent {
  const EnableEvent();
  @override
  void apply(field) => field.enable();

  @override
  void reverse(field) => field.disable();
}

class DisableEvent extends _ReverseTriggerEventAdaptor {
  const DisableEvent() : super(const EnableEvent());
}

class SetValueEvent extends TriggerEvent {
  final String value;
  const SetValueEvent(this.value);
  @override
  void apply(field) => field.setValue(value);

  @override
  void reverse(field) {}
}

class ClearEvent extends TriggerEvent {
  @override
  void apply(field) => field.clear();

  @override
  void reverse(field) {}
}

class FieldErrorEvent extends TriggerEvent {
  final String errorMessage;
  const FieldErrorEvent(this.errorMessage);
  @override
  void apply(field) => field.setError(errorMessage);

  @override
  void reverse(field) => field.clearError();
}

// class FormErrorEvent extends TriggerEvent {
//   final String errorMessage;
//   const FormErrorEvent(this.errorMessage);
//   @override
//   void apply(field) => field.form.setError(errorMessage);

//   @override
//   void reverse(field) => field.form.clearError();
// }
