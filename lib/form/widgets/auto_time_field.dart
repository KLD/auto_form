import 'package:auto_form/form/abstract/auto_field_state.dart';

import '../../helper/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../abstract/auto_field_widget.dart';

final _timeFormatter = DateFormat('HH:mm', "en-us");

class AutoTimeField extends AutoFieldWidget {
  final DateTime? startTime;
  final DateTime? endTime;

  AutoTimeField({
    super.key,
    required super.id,
    required super.label,
    this.startTime,
    this.endTime,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  State<AutoFieldWidget> createState() => _AutoTimeFieldState();
}

class _AutoTimeFieldState extends AutoFieldState<AutoTimeField> {
  DateTime? selected;
  bool isFocused = false;
  @override
  void initState() {
    super.initState();

    if (widget.initValue.isNotEmpty) {
      selected = _timeFormatter.parse(widget.initValue);
      widget.setValue(_timeFormatter.format(selected!));
    }

    widget.onValueSet.add((value) {
      if (value.isEmpty) {
        setState(() {
          selected = null;
        });
      }
    });
  }

  @override
  Widget buildField(BuildContext context) {
    return FormField<String>(
        validator: widget.fieldValidator,
        builder: (fieldState) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                isFocused = true;
              });
              var date = await DateTimePicker.pickTime(
                context,
                minimumDate: widget.startTime,
                maximumDate: widget.endTime,
                initialDateTime: selected,
              );

              setState(
                () {
                  isFocused = false;
                  if (date == null) return;
                  selected = date;
                  widget.setValue(_timeFormatter.format(date));
                },
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDecorator(
                    isEmpty: selected == null,
                    isFocused: isFocused,
                    decoration: InputDecoration(
                        labelText: widget.label,
                        suffixIcon: selected == null ? null : buildClearIcon()),
                    child: selected == null
                        ? const Text("")
                        : Text(_timeFormatter.format(selected!))),
                if (fieldState.hasError)
                  Text(fieldState.errorText!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error))
              ],
            ),
          );
        });
  }
}
