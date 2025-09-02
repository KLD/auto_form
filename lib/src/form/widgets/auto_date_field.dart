import 'package:flutter/material.dart';

import '../../helper/date_time_picker.dart';
import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

class AutoDateField extends AutoFieldWidget {
  final DateTime? startDate;
  final DateTime? endDate;

  AutoDateField({
    super.key,
    required super.id,
    required super.label,
    this.startDate,
    this.endDate,
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
  DateTime? selected;

  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    if (widget.initValue.isNotEmpty) {
      selected = parseDateTime(widget.initValue);
      setValue(formatDate(selected!));
    }

    onValueSet.add((value) {
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
        validator: fieldValidator,
        builder: (fieldState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _selectDate,
                child: InputDecorator(
                    isEmpty: selected == null,
                    isFocused: isFocused,
                    decoration: InputDecoration(
                        labelText: widget.label,
                        suffixIcon: selected == null ? null : buildClearIcon()),
                    child: selected == null
                        ? const Text("")
                        : Text(formatDate(selected!))),
              ),
              if (fieldState.hasError)
                Text(fieldState.errorText!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error))
            ],
          );
        });
  }

  void _selectDate() async {
    setState(() {
      isFocused = true;
    });
    var date = await DateTimePicker.pickDate(
      context,
      minimumDate: widget.startDate,
      maximumDate: widget.endDate,
      initialDateTime: selected,
    );

    setState(
      () {
        isFocused = false;
        if (date == null) return;
        selected = date;
        setValue(formatDate(date));
      },
    );
  }
}

DateTime parseDateTime(String value) {
  // validate string
  if (value.isEmpty) {
    throw "Empty string";
  }
// validate format regex 2000-1-01
  if (!RegExp(r"^\d{4}-\d{1,2}-\d{1,2}$").hasMatch(value)) {
    throw "Invalid date format. Must be yyyy-mm-dd";
  }

  var tokens = value.split("-");
  return DateTime(
      int.parse(tokens[0]), int.parse(tokens[1]), int.parse(tokens[2]));
}

String formatDate(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}
