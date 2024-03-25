import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_bar_model.dart';
import 'package:auto_form/form/widgets/auto_date_field.dart';
import 'package:auto_form/form/widgets/auto_dropdown_field.dart';
import 'package:flutter/material.dart';

class PACIEarlyLeaveForm extends StatefulWidget {
  const PACIEarlyLeaveForm({super.key});

  @override
  PACIEarlyLeaveFormState createState() => PACIEarlyLeaveFormState();
}

class PACIEarlyLeaveFormState extends State<PACIEarlyLeaveForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PACI Early Leave Form'),
        ),
        body: AutoForm(
          onSubmit: (data) {},
          children: [
            AutoDropdownField(
              id: "type",
              label: "Leave Type",
              items: [
                DropdownItem(label: "Personal", value: "personal_leave"),
                DropdownItem(label: "Medical", value: "medical_leave"),
                DropdownItem(label: "Work", value: "work_leave"),
              ],
            ),
            AutoDateField(
              id: "date",
              label: "Date",
              initValue: DateTime.now().toString(),
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 14)),
            ),
            AutoBarField(
              id: "bar",
              label: "Remaining Time",
              color: Colors.green,
              initValue: "0.5",
              valueLabel: "12/12",
            ),
          ],
        ));
  }
}
