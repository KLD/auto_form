import 'package:auto_form/form/widgets/auto_computed_field.dart';
import 'package:flutter/material.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_trigger.dart';
import 'package:auto_form/form/abstract/field_validation.dart';
import 'package:auto_form/form/abstract/trigger_event.dart';
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
            AutoTextField(
              id: "first_name",
              label: "First Name",
              triggers: const [
                FieldTrigger.other(
                  fieldId: "last_name",
                  value: "ping",
                  condition: EqualsCondition(),
                  event: SetValueEvent("pong"),
                ),
                FieldTrigger.other(
                  fieldId: "age",
                  event: HideEvent(),
                  value: "hide",
                  condition: EqualsCondition(),
                ),
              ],
              validations: const [
                NotEqualsValidation(value: "kld0"),
                RegexValidation.reverse(
                  errorMessage: "Letters only",
                  value: r"[a-zA-Z]+",
                ),
              ],
            ),
            const Text("Note: Please write your full name"),
            AutoTextField(
              id: "last_name",
              label: "Last Name",
            ),
            AutoTextField(
              id: "age",
              label: "Age",
            ),
            AutoTextField(
              id: "first_name_again",
              label: "First Name again",
              validations: const [
                EqualsValidation(value: "@first_name"),
              ],
              triggers: const [
                FieldTrigger.other(
                  fieldId: "full_name",
                  value: "error",
                  condition: EqualsCondition(),
                  event: FormErrorEvent("BIG ERROR"),
                ),
              ],
            ),
            AutoComputedField(
              id: "full_name",
              label: "Full Name",
              fieldIdA: "@first_name",
              fieldIdB: "@last_name",
              hidden: false,
              operation: AddOperation(),
            )
          ],
        ),
      ),
    );
  }
}
