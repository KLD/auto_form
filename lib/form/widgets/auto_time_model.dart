import '../../helper/date_time_picker.dart';
import '../abstract/auto_field_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../abstract/auto_field.dart';

final _timeFormatter = DateFormat('HH:mm', "en-us");

class DynamicTimeModel extends AutoFieldModel {
  final DateTime? minimumTime;
  final DateTime? maximumTime;

  DynamicTimeModel({
    required super.id,
    required super.label,
    required this.minimumTime,
    required this.maximumTime,
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  AutoField<AutoFieldModel> asWidget({Key? key}) =>
      DynamicTimeField(model: this, key: key);
}

class DynamicTimeField extends AutoField<DynamicTimeModel> {
  DynamicTimeField({
    required super.model,
    super.key,
  });

  @override
  State<AutoField> createState() => _DynamicTimeFieldState();
}

class _DynamicTimeFieldState extends State<DynamicTimeField> {
  DateTime? date;
  @override
  void initState() {
    super.initState();

    if (widget.model.initValue.isNotEmpty) {
      date = _timeFormatter.parse(widget.model.initValue);
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
                minimumDate: widget.model.minimumTime,
                maximumDate: widget.model.maximumTime,
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
                      labelText: widget.model.label,
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
