import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helper/date_time_picker.dart';
import '../abstract/base_dynamic_field.dart';
import '../abstract/dynamic_field_model.dart';

final dateFormatter = DateFormat('yyyy-MM-dd', ("en-us"));

class DynamicDateModel extends DynamicFieldModel {
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  DynamicDateModel({
    required super.id,
    required super.label,
    required this.minimumDate,
    required this.maximumDate,
    super.enabled = true,
    super.hidden = false,
    super.required = false,
    super.validations = const [],
    super.triggers = const [],
    super.initValue,
  });

  @override
  BaseDynamicField<DynamicFieldModel> asWidget({Key? key}) =>
      DynamicDateField(model: this, key: key);
}

class DynamicDateField extends BaseDynamicField<DynamicDateModel> {
  DynamicDateField({
    required super.model,
    super.key,
  });

  @override
  State<BaseDynamicField> createState() => _DynamicDateFieldState();
}

class _DynamicDateFieldState extends State<DynamicDateField> {
  DateTime? date;
  @override
  void initState() {
    super.initState();

    if (widget.model.initValue.isNotEmpty) {
      date = dateFormatter.parse(widget.model.initValue);
      widget.setValue(dateFormatter.format(date!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.fieldValidator,
        builder: (fieldState) {
          return InkWell(
            onTap: () async {
              var date = await DateTimePicker.pickDate(
                context,
                minimumDate: widget.model.minimumDate,
                maximumDate: widget.model.maximumDate,
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
                      labelText: widget.model.label,
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
