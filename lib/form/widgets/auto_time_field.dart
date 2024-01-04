import '../../helper/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../abstract/auto_field_widget.dart';

final _timeFormatter = DateFormat('HH:mm', "en-us");

class AutoTimeField extends AutoFieldWidget {
  final DateTime? minimumTime;
  final DateTime? maximumTime;

  AutoTimeField({
    super.key,
    required super.id,
    required super.label,
    required this.minimumTime,
    required this.maximumTime,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  State<AutoFieldWidget> createState() => _DynamicTimeFieldState();
}

class _DynamicTimeFieldState extends State<AutoTimeField> {
  DateTime? date;
  @override
  void initState() {
    super.initState();

    if (widget.initValue.isNotEmpty) {
      date = _timeFormatter.parse(widget.initValue);
      widget.setValue(_timeFormatter.format(date!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.fieldValidator,
        builder: (fieldState) {
          return InkWell(
            onTap: () async {
              var date = await DateTimePicker.pickTime(
                context,
                minimumDate: widget.minimumTime,
                maximumDate: widget.maximumTime,
                initialDateTime: this.date,
              );

              setState(
                () {
                  if (date == null) return;
                  this.date = date;
                  widget.setValue(_timeFormatter.format(date));
                },
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDecorator(
                    isEmpty: date == null,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.watch_later_outlined),
                      labelText: widget.label,
                    ),
                    child: date == null
                        ? const Text("")
                        : Text(_timeFormatter.format(date!))),
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
