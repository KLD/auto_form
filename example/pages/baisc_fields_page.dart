import 'package:auto_form/src/form/auto_form.dart';
import 'package:flutter/material.dart';

class BasicFieldsPage extends StatelessWidget {
  const BasicFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoForm(
        onSubmit: (v) {
          // ignore: avoid_print
          print(v);
        },
        children: [
          AutoTextField(
            id: "text",
            label: "Text",
          ),
          AutoDropdownField(
            id: "dropdown",
            label: "Dropdown",
            items: [
              DropdownItem(value: "a"),
              DropdownItem(value: "b"),
              DropdownItem(value: "c", label: "C"),
            ],
          ),
          AutoDateField(id: "date", label: "Date"),
          AutoTimeField(id: "time", label: "Time"),
        ],
      ),
    );
  }
}
