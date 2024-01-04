import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_trigger.dart';
import 'package:auto_form/form/abstract/field_validation.dart';
import 'package:auto_form/form/abstract/trigger_event.dart';
import 'package:auto_form/form/widgets/auto_checkbox_field.dart';
import 'package:auto_form/form/widgets/auto_computed_field.dart';
import 'package:auto_form/form/widgets/auto_date_field.dart';
import 'package:auto_form/form/widgets/auto_dropdown_field.dart';
import 'package:auto_form/form/widgets/auto_group_field.dart';
import 'package:auto_form/form/widgets/auto_time_field.dart';
import 'package:flutter/material.dart';
import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: AutoForm(
          onSubmit: (data) {
            print(data);
          },
          children: [
            const Text("Hello World"),
            // AutoTextField(
            //   id: "first_name",
            //   label: "First Name",
            //   validations: const [
            //     RequiredValidation(),
            //   ],
            // ),
            // AutoTextField(
            //   id: "last_name",
            //   label: "Last Name",
            // ),
            AutoDropdownField(
              id: "genders",
              label: "Gendres",
              items: [
                DropdownItem(label: "Male", value: "male"),
                DropdownItem(label: "Female", value: "female"),
              ],
              triggers: const [
                FieldTrigger.other(
                    fieldId: "full_name",
                    value: "male",
                    condition: EqualsCondition(),
                    event: ShowEvent())
              ],
            ),

            AutoGroupField(
              id: "full_name",
              label: "User name",
              hidden: true,
              children: [
                AutoTextField(
                  id: "first_name",
                  label: "First Name",
                  validations: const [
                    RequiredValidation(),
                  ],
                ),
                AutoTextField(
                  id: "last_name",
                  label: "Last Name",
                ),
              ],
            ),
            // AutoCheckboxField(id: "accept", label: "Accept terms and services"),
            // AutoDateField(
            //   id: "birth",
            //   label: "Birth Date",
            //   minimumDate: DateTime(1900),
            //   maximumDate: DateTime.now(),
            //   initValue: DateTime.now().toString(),
            // ),
            // AutoTimeField(
            //   id: "worthTime",
            //   label: "Time to go to work",
            //   minimumTime: DateTime(1900),
            //   maximumTime: DateTime.now(),
            // ),
            // AutoComputedField(
            //   id: "sum",
            //   label: "Sum",
            //   hidden: false,
            //   fields: const [
            //     "@first_name",
            //     "10:00",
            //     "@last_name",
            //   ],
            //   operation: AddOperation(),
            // ),
            // AutoComputedField(
            //   id: "sum2",
            //   label: "Another sum",
            //   hidden: false,
            //   fields: const [
            //     "The selected duration is: ",
            //     "@sum",
            //   ],
            //   operation: AddOperation(),
            // ),
          ],
        ),
      ),
    );
  }
}
