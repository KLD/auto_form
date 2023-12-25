import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_validation.dart';
import 'package:auto_form/form/dynamic_form.dart';
import 'package:auto_form/form/widgets/dynamic_text_model.dart';

void main() {
  testWidgets("DynamicText validation MatchOperation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Cannot be 123",
                    value: r"123",
                    condition: MatchCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));
    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("123");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Cannot be 123"), findsOneWidget);
  });

  testWidgets("DynamicText validation NotMatchOperation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Letters only",
                    value: r"[a-zA-Z]+",
                    condition: NotMatchCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("Khaled1122");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Letters only"), findsOneWidget);
  });

  testWidgets("DynamicText validation EqualsOperation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Some Error",
                    value: "IllegalWord",
                    condition: EqualsCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("IllegalWord");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Some Error"), findsOneWidget);
  });
  testWidgets("DynamicText validation NotEqualsOperation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Some Error",
                    value: "LegalWord",
                    condition: NotEqualsCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("IllegalWord");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Some Error"), findsOneWidget);
  });

  testWidgets("DynamicText validation NotEqualsOperation should not appear",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Some Error",
                    value: "LegalWord",
                    condition: NotEqualsCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("LegalWord");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Some Error"), findsNothing);
  });

  testWidgets("DynamicText validation GreaterCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Must be less than 5",
                    value: "5",
                    condition: GreaterCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("6");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Must be less than 5"), findsOneWidget);
  });
  testWidgets("DynamicText validation GreaterCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Must be less than 5",
                    value: "5",
                    condition: GreaterCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("5");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Must be less than 5"), findsNothing);
  });

  testWidgets("DynamicText validation GreaterOrEqualsCondition",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: GreaterOrEqualsCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("5");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsOneWidget);
  });
  testWidgets("DynamicText validation GreaterCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "Must be less or equal than 5",
                    value: "5",
                    condition: GreaterCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("4");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("Must be less than 5"), findsNothing);
  });

  testWidgets("DynamicText validation LessCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("4");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsOneWidget);
  });

  testWidgets("DynamicText validation LessCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("5");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsNothing);
  });

  testWidgets("DynamicText validation LessOrEqualsCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessOrEqualsCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("4");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsOneWidget);
  });

  testWidgets("DynamicText validation LessOrEqualsCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              validations: [
                const FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessOrEqualsCondition())
              ],
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    textState.widget.setValue("6");
    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsNothing);
  });
}
