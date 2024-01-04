import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helper/date_time_picker.dart';
import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

final dateFormatter = DateFormat('yyyy-MM-dd', ("en-us"));

class AutoDateField extends AutoFieldWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  AutoDateField({
    super.key,
    required super.id,
    required super.label,
    required this.minimumDate,
    required this.maximumDate,
    super.enabled = true,
    super.hidden = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  State<AutoFieldWidget> createState() => AutoDateState();
}

class AutoDateState extends AutoFieldState<AutoDateField> {
  DateTime? date;
  @override
  void initState() {
    super.initState();

    if (widget.initValue.isNotEmpty) {
      date = dateFormatter.parse(widget.initValue);
      widget.setValue(dateFormatter.format(date!));
    }
  }

  @override
  Widget buildField(BuildContext context) {
    return FormField<String>(
        validator: widget.fieldValidator,
        builder: (fieldState) {
          return InkWell(
            onTap: () async {
              var date = await DateTimePicker.pickDate(
                context,
                minimumDate: widget.minimumDate,
                maximumDate: widget.maximumDate,
                initialDateTime: this.date,
              );

              setState(
                () {
                  if (date == null) return;
                  this.date = date;
                  widget.setValue(dateFormatter.format(date));
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
                      suffixIcon: const Icon(Icons.calendar_month),
                      labelText: widget.label,
                    ),
                    child: date == null
                        ? const Text("")
                        : Text(
                            DateFormat('yyyy-MM-dd', "en-us").format(date!))),
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
