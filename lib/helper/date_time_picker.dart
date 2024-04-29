import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialDateTime;

  final CupertinoDatePickerMode mode;

  const DateTimePicker(
      {required this.mode,
      this.minimumDate,
      this.maximumDate,
      this.initialDateTime,
      super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();

  static Future<DateTime?> pickTime(
    BuildContext context, {
    DateTime? minimumDate,
    DateTime? maximumDate,
    DateTime? initialDateTime,
  }) async {
    return await showModalBottomSheet<DateTime?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DateTimePicker(
        mode: CupertinoDatePickerMode.time,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        initialDateTime: initialDateTime,
      ),
    );
  }

  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? minimumDate,
    DateTime? maximumDate,
    DateTime? initialDateTime,
  }) async {
    if (minimumDate != null) {
      minimumDate = DateUtils.dateOnly(minimumDate);
    }
    if (maximumDate != null) {
      maximumDate = DateUtils.dateOnly(maximumDate);
    }
    if (initialDateTime != null) {
      initialDateTime = DateUtils.dateOnly(initialDateTime);

      if (minimumDate != null && initialDateTime.isBefore(minimumDate)) {
        initialDateTime = minimumDate;
      }
      if (maximumDate != null && initialDateTime.isAfter(maximumDate)) {
        initialDateTime = maximumDate;
      }
    }

    return await showModalBottomSheet<DateTime?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DateTimePicker(
        mode: CupertinoDatePickerMode.date,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        initialDateTime: initialDateTime,
      ),
    );
  }
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? pickedDate;
  @override
  void initState() {
    if (widget.initialDateTime != null) {
      pickedDate = widget.initialDateTime;
    }
    // lol
    else if ((widget.maximumDate == null ||
            (widget.maximumDate != null &&
                DateTime.now().isBefore(widget.maximumDate!))) &&
        (widget.minimumDate == null ||
            (widget.minimumDate != null &&
                DateTime.now().isAfter(widget.minimumDate!)))) {
      pickedDate = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
        context: context,
        locale: const Locale('en'),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: pickedDate == null
                        ? null
                        : () => Navigator.of(context).pop(pickedDate),
                    child: const Text("Done"),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: CupertinoDatePicker(
                    mode: widget.mode,
                    use24hFormat: true,
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: widget.initialDateTime,
                    minimumDate: widget.minimumDate,
                    maximumDate: widget.maximumDate,
                    minimumYear: widget.minimumDate?.year ?? 1,
                    maximumYear: widget.maximumDate?.year,
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        pickedDate = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
