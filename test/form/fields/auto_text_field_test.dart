import 'package:auto_form_plus/src/form/auto_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("AutoText renders", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(id: "text", label: "Name"),
          ],
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "", reason: "Value was never set");
  });

  testWidgets("AutoText has assigned defaults and model values",
      (tester) async {
    var model = AutoTextField(
      id: "text",
      label: "Name",
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            model,
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var form = tester.state<AutoFormState>(find.byType(AutoForm));
    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    var field = textState;
    expect(field.isEnabled, model.enabled,
        reason: "enabled doesn't match model");
    expect(field.isHidden, model.hidden, reason: "hidden doesn't match model");
    expect(field.value, model.initValue, reason: "value doesn't match model");
    expect(field.form, form.widget, reason: "Form was not set");
    expect(field, model, reason: "Model was modified");
  });

  testWidgets("AutoText setValues alters value", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(id: "text", label: "Name"),
          ],
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);

    var text = tester.state<AutoTextFieldState>(find.byType(AutoTextField));
    text.setValue("hello");

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "hello", reason: "Value was never set");
  });

  testWidgets("AutoText has initValue", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              initValue: "John Doe",
            ),
          ],
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "John Doe", reason: "Value was set");
  });

  testWidgets("AutoText clears value", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              initValue: "John Doe",
            ),
          ],
          onSubmit: (data) {
            result = data;
          },
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));
    textState.clear();

    var state = tester.state<AutoFormState>(find.byType(AutoForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "", reason: "Value was set");
  });

  testWidgets("AutoText can be hidden", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              hidden: true,
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsNothing);
  });

  testWidgets("AutoText was enabled becomes disabled", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    expect(textState.isEnabled, true);
    state.disableField("text");
    expect(textState.isEnabled, false);
  });

  testWidgets("AutoText was disabled becomes enabled", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              enabled: false,
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    expect(textState.isEnabled, false, reason: "defaults to false");
    state.enableField("text");
    expect(textState.isEnabled, true, reason: "was set to true");
  });

  testWidgets("AutoText was visable becomes hidden", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));
    expect(find.byType(TextFormField), findsOneWidget);

    expect(textState.isHidden, false, reason: "defaults to false");
    state.hideField("text");
    expect(textState.isHidden, true, reason: "was set to true");

    await tester.pump();
    expect(find.byType(TextFormField), findsNothing);
  });
  testWidgets("AutoText was hidden becomes visible", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
              hidden: true,
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    expect(find.byType(TextFormField), findsNothing);

    state.showField("text");
    await tester.pump();
    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));
    expect(textState.isHidden, false, reason: "was set to true");

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets("AutoText sets error message", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    expect(find.byType(TextFormField), findsOneWidget);

    state.setError("text", "error here");
    await tester.pump();

    expect(find.text("error here"), findsOneWidget);
  });

  testWidgets("AutoText error clears after calling clear()", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              id: "text",
              label: "Name",
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    expect(find.byType(TextFormField), findsOneWidget);

    state.setError("text", "error here");
    await tester.pump();

    expect(find.text("error here"), findsOneWidget);

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));
    textState.clear();
    await tester.pump();
    expect(find.text("error here"), findsNothing);
  });
}
