import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helper/date_time_picker.dart';
import '../abstract/auto_field_state.dart';
import '../abstract/auto_field_widget.dart';

final dateFormatter = DateFormat('yyyy-MM-dd', ("en-us"));

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
      selected = dateFormatter.parse(widget.initValue);
      widget.setValue(dateFormatter.format(selected!));
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
                        : Text(DateFormat('yyyy-MM-dd', "en-us")
                            .format(selected!))),
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
        widget.setValue(dateFormatter.format(date));
      },
    );
  }
}
