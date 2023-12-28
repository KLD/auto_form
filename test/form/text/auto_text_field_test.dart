import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_text_model.dart';

void main() {
  testWidgets("AutoText renders", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text", label: "Name").asWidget(),
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
    var model = AutoTextModel(
      id: "text",
      label: "Name",
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            model.asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var form = tester.state<AutoFormState>(find.byType(AutoForm));
    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    var field = textState.widget;
    expect(field.enabled.value, model.enabled,
        reason: "enabled doesn't match model");
    expect(field.hidden.value, model.hidden,
        reason: "hidden doesn't match model");
    expect(field.value, model.initValue, reason: "value doesn't match model");
    expect(field.form, form.widget, reason: "Form was not set");
    expect(field.model, model, reason: "Model was modified");
  });

  testWidgets("AutoText setValues alters value", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text", label: "Name").asWidget(),
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
    text.widget.setValue("hello");

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
            AutoTextModel(
              id: "text",
              label: "Name",
              initValue: "John Doe",
            ).asWidget(),
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
            AutoTextModel(
              id: "text",
              label: "Name",
              initValue: "John Doe",
            ).asWidget(),
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
    textState.widget.clear();

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
            AutoTextModel(
              id: "text",
              label: "Name",
              hidden: true,
            ).asWidget(),
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
            AutoTextModel(
              id: "text",
              label: "Name",
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    expect(textState.widget.enabled.value, true);
    state.disableField("text");
    expect(textState.widget.enabled.value, false);
  });

  testWidgets("AutoText was disabled becomes enabled", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(
              id: "text",
              label: "Name",
              enabled: false,
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));

    expect(textState.widget.enabled.value, false, reason: "defaults to false");
    state.enableField("text");
    expect(textState.widget.enabled.value, true, reason: "was set to true");
  });

  testWidgets("AutoText was visable becomes hidden", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(
              id: "text",
              label: "Name",
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<AutoFormState>(find.byType(AutoForm));

    var textState =
        tester.state<AutoTextFieldState>(find.byType(AutoTextField));
    expect(find.byType(TextFormField), findsOneWidget);

    expect(textState.widget.hidden.value, false, reason: "defaults to false");
    state.hideField("text");
    expect(textState.widget.hidden.value, true, reason: "was set to true");

    await tester.pump();
    expect(find.byType(TextFormField), findsNothing);
  });
  testWidgets("AutoText was hidden becomes visible", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(
              id: "text",
              label: "Name",
              hidden: true,
            ).asWidget(),
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
    expect(textState.widget.hidden.value, false, reason: "was set to true");

    expect(find.byType(TextFormField), findsOneWidget);
  });
}
