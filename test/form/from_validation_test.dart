import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_validation.dart';
import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_text_field.dart';

void main() {
  testWidgets("AutoText validation RegexValidation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                RegexValidation(
                  errorMessage: "Cannot be 123",
                  value: r"123",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));
    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("123");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Cannot be 123"), findsOneWidget);
  });
  testWidgets("AutoText validation RegexValidation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                RegexValidation(
                  errorMessage: "Cannot be 123",
                  value: r"123",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));
    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("123");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Cannot be 123"), findsOneWidget);
  });

  testWidgets("AutoText validation RegexValidation.reverse", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                RegexValidation.reverse(
                  errorMessage: "Letters only",
                  value: r"[a-zA-Z]+",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("Khaled1122");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Letters only"), findsOneWidget);
  });

  testWidgets("AutoText validation EqualsValidation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                EqualsValidation(
                  errorMessage: "Some Error",
                  value: "IllegalWord",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("IllegalWord");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Some Error"), findsOneWidget);
  });

  testWidgets("AutoText validation EqualsValidation default error message",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                EqualsValidation(
                  value: "IllegalWord",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("IllegalWord");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("${EqualsValidation.defaultErrorMessage}IllegalWord"),
        findsOneWidget);
  });
  testWidgets("AutoText validation NotEqualsOperation", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                NotEqualsValidation(
                  errorMessage: "Some Error",
                  value: "LegalWord",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("IllegalWord");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Some Error"), findsOneWidget);
  });

  testWidgets(
      "AutoText validation NotEqualsOperation with default error message",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                NotEqualsValidation(
                  value: "LegalWord",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("IllegalWord");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("${NotEqualsValidation.defaultErrorMessage}LegalWord"),
        findsOneWidget);
  });

  testWidgets("AutoText validation NotEqualsOperation should not appear",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                NotEqualsValidation(
                  errorMessage: "Some Error",
                  value: "LegalWord",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("LegalWord");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Some Error"), findsNothing);
  });

  testWidgets("AutoText validation GreaterCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "Must be less than 5",
                    value: "5",
                    condition: GreaterCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("6");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Must be less than 5"), findsOneWidget);
  });

  testWidgets("AutoText validation GreaterCondition with default error message",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                GreaterValidation(
                  value: "5",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("6");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(
        find.text("${GreaterValidation.defaultErrorMessage}5"), findsOneWidget);
  });
  testWidgets("AutoText validation GreaterCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "Must be less than 5",
                    value: "5",
                    condition: GreaterCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("5");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Must be less than 5"), findsNothing);
  });

  testWidgets("AutoText validation GreaterOrEqualsCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: GreaterOrEqualsCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("5");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsOneWidget);
  });
  testWidgets(
      "AutoText validation GreaterOrEqualsCondition with default error message",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                GreaterOrEqualsValidation(
                  value: "5",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("5");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("${GreaterOrEqualsValidation.defaultErrorMessage}5"),
        findsOneWidget);
  });
  testWidgets("AutoText validation GreaterCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "Must be less or equal than 5",
                    value: "5",
                    condition: GreaterCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("4");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("Must be less than 5"), findsNothing);
  });

  testWidgets("AutoText validation LessCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("4");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsOneWidget);
  });
  testWidgets("AutoText validation LessCondition with error message",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                LessValidation(
                  value: "5",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("4");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("${LessValidation.defaultErrorMessage}5"), findsOneWidget);
  });

  testWidgets("AutoText validation LessCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("5");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsNothing);
  });

  testWidgets("AutoText validation LessOrEqualsCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessOrEqualsCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("4");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsOneWidget);
  });

  testWidgets(
      "AutoText validation LessOrEqualsCondition with default error message",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                LessOrEqualsValidation(
                  value: "5",
                )
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("4");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("${LessOrEqualsValidation.defaultErrorMessage}5"),
        findsOneWidget);
  });

  testWidgets("AutoText validation LessOrEqualsCondition should not trigger",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                FieldValidation(
                    errorMessage: "error message",
                    value: "5",
                    condition: LessOrEqualsCondition())
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    textState.widget.setValue("6");
    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text("error message"), findsNothing);
  });
  testWidgets("AutoText validation RequiredCondition", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              validations: const [
                RequiredValidation(),
              ],
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();

    await tester.pump();

    expect(find.text(RequiredValidation.defaultErrorMessage), findsOneWidget);
  });
}
