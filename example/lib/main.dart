import 'package:flutter/material.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_trigger.dart';
import 'package:auto_form/form/abstract/field_validation.dart';
import 'package:auto_form/form/abstract/trigger_event.dart';
import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_text_model.dart';

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
            AutoTextModel(
              id: "first_name",
              label: "First Name",
              triggers: [
                const FieldTrigger(
                    fieldId: "last",
                    value: r"\w+\s+\w+",
                    condition: NotMatchCondition(),
                    event: DisableEvent()),
                const FieldTrigger(
                  fieldId: "age",
                  value: r"\w+\s+\w+",
                  condition: NotMatchCondition(),
                  event: DisableEvent(),
                ),
              ],
              validations: [
                const FieldValidation(
                  errorMessage: "Letters only",
                  value: r"[a-zA-Z]+",
                  condition: NotMatchCondition(),
                ),
              ],
            ).asWidget(),
            const Text("Note: Please write your full name"),
            AutoTextModel(
              id: "last",
              label: "Last Name",
            ).asWidget(),
            AutoTextModel(
              id: "age",
              label: "Age",
            ).asWidget(),
          ],
        ),
      ),
    );
  }
}
