import 'package:auto_form_plus/auto_form.dart';
import 'package:auto_form_plus/src/form/widgets/auto_computed_field.dart';
import 'package:flutter/material.dart';

class ComputedFieldExample extends StatelessWidget {
  const ComputedFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Computed Field Example'),
      ),
      body: AutoForm(
        onSubmit: (value) {
          // ignore: avoid_print
          print(value);
        },
        children: [
          AutoTextField(id: "a", label: "A", initValue: "test"),
          AutoTextField(id: "b", label: "B"),
          AutoComputedField(
            id: "computed",
            values: ["@a", "@b"],
            operation: AddOperation(),
            hidden: false,
          )
        ],
      ),
    );
  }
}
