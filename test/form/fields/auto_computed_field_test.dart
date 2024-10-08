import 'package:auto_form/src/form/auto_form.dart';
import 'package:auto_form/src/form/widgets/auto_computed_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("AutoComputedField renders", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(id: "text1", label: "Name"),
            AutoTextField(id: "text2", label: "Name"),
            AutoComputedField(
              id: "full_text",
              label: "Full Name",
              fields: const ["@text1", "@text2"],
              operation: AddOperation(),
            ),
          ],
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(AutoComputedField), findsOneWidget);

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();
    expect(result.length, 3, reason: "Three values should be rendered");
    expect(result["full_text"], "", reason: "Value was never set");
  });
}
