import 'package:auto_form/src/form/auto_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("renders empty form", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(AutoForm), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();
    expect(result.isEmpty, true);
  });
}
