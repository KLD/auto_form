import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_validation.dart';
import 'package:auto_form/form/dynamic_form.dart';
import 'package:auto_form/form/widgets/dynamic_text_model.dart';

void main() {
  group("Field validation string", () {
    testWidgets("equals to string ", (tester) async {
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
                      value: "string",
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

      textState.widget.setValue("string");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("equal to number", (tester) async {
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
                      value: "string",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to duration", (tester) async {
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
                      value: "string",
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

      textState.widget.setValue("2020-12-30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to duration", (tester) async {
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
                      value: "string",
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

      textState.widget.setValue("10:10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
  });

  group("Field validation number", () {
    testWidgets("equals to string", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("string");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("equal to date", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("2020-12-30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to duration", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("10:10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("less than number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("9");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than number given equal number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("less than number given greater number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("11");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("less than or equals number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("9");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than or equals given equal number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than or equals given greater number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("11");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("greater than number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("15");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("greater than given equal number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("greater given less number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("9");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("greater or equals than equals number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("greater or equals than given greater number", (tester) async {
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
                      value: "10",
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

      textState.widget.setValue("15");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
  });

  group("Field validation date", () {
    testWidgets("equals to string", (tester) async {
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
                      value: "200-1-10",
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

      textState.widget.setValue("string");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to number", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("equal to duration", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("10:10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("not equal date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-9");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("less than date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-09");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than given equal date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("less than given greater date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-11");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("less than or equals date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-09");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than or equals given equal date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than or equals given greater date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-11");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("greater than date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-11");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("greater than given equal date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("greater given less date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-09");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("greater or equals than equals date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("greater or equals than given greater date", (tester) async {
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
                      value: "2000-1-10",
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

      textState.widget.setValue("2000-1-11");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
  });

  group("Field validation duration", () {
    testWidgets("equals to string", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("string");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to number", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to date", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("2000-1-10");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("equal to duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("equal to duration with different format", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30:00");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("not equal duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30:01");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("less than duration given less duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:29");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
    testWidgets("less than given equal duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("less than given greater duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:31");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("less than or equals given less duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:29");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than or equals given equal duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("less than or equals given greater duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30:01");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("greater than duration given greater duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:31");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("greater than given equal duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });

    testWidgets("greater given less duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:29");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsNothing);
    });
    testWidgets("greater or equals than equals duration", (tester) async {
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
                      value: "12:30",
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

      textState.widget.setValue("12:30");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });

    testWidgets("greater or equals than given greater duration",
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
                      value: "12:30",
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

      textState.widget.setValue("12:31");
      var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
      state.submit();

      await tester.pump();

      expect(find.text("Some Error"), findsOneWidget);
    });
  });
}
