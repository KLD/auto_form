import 'package:auto_form/src/form/abstract/auto_field_state.dart';
import 'package:flutter/material.dart';

import '../../helper/date_time_picker.dart';
import '../abstract/auto_field_widget.dart';

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
      selected = parseTime(widget.initValue);
      widget.setValue(formatTime(selected!));
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
                  widget.setValue(formatTime(date));
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
                    contentPadding: EdgeInsets.zero,
                    labelText: widget.label,
                    suffixIcon: selected == null ? null : buildClearIcon(),
                    prefix: selected == null
                        ? null
                        : Text(
                            formatTime(selected!),
                          ),
                  ),
                ),
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

DateTime parseTime(String value) {
  if (value.isEmpty) {
    throw "Empty string";
  }
  if (!RegExp(r"^\d{1,2}:\d{1,2}$").hasMatch(value)) {
    throw "Invalid time format. Must be hh:mm";
  }

  var tokens = value.split(":");
  return DateTime(int.parse(tokens[0]), int.parse(tokens[1]));
}

String formatTime(DateTime date) {
  return "${date.hour}:${date.minute}";
}
