import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_form/form/dynamic_form.dart';

void main() {
  testWidgets("renders empty form", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(DynamicForm), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();
    expect(result.isEmpty, true);
  });
}
