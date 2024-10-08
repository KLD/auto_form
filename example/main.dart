import 'package:auto_form/src/form/auto_form.dart';
import 'package:flutter/material.dart';

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
            // ignore: avoid_print
            print(data);
          },
          children: [
            const Text("Hello World"),
            AutoFileField(
              id: "file",
              label: "Image",
              fileSource: const [FileSource.gallery],
              settings: const FilePickSettings(maxHeight: 100, maxWidth: 100),
            ),
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

            AutoGroupField.row(
              id: "full_name",
              label: "User name",
              hidden: true,
              children: [
                Expanded(
                  child: AutoTextField(
                    id: "first_name",
                    label: "First Name",
                    validations: const [
                      RequiredValidation(),
                    ],
                  ),
                ),
                Expanded(
                  child: AutoTimeField(
                    id: "time",
                    label: "Time",
                  ),
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
