import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_form/form/dynamic_form.dart';
import 'package:json_form/form/widgets/dynamic_text_model.dart';

void main() {
  testWidgets("DynamicText renders", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(id: "text", label: "Name").asWidget(),
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

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "", reason: "Value was never set");
  });

  testWidgets("DynamicText has assigned defaults and model values",
      (tester) async {
    var model = DynamicTextModel(
      id: "text",
      label: "Name",
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            model.asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var form = tester.state<DynamicFormState>(find.byType(DynamicForm));
    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    var field = textState.widget;
    expect(field.enabled.value, model.enabled,
        reason: "enabled doesn't match model");
    expect(field.hidden.value, model.hidden,
        reason: "hidden doesn't match model");
    expect(field.value, model.initValue, reason: "value doesn't match model");
    expect(field.form, form.widget, reason: "Form was not set");
    expect(field.model, model, reason: "Model was modified");
  });

  testWidgets("DynamicText setValues alters value", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(id: "text", label: "Name").asWidget(),
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

    var text =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));
    text.widget.setValue("hello");

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "hello", reason: "Value was never set");
  });

  testWidgets("DynamicText has initValue", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
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

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "John Doe", reason: "Value was set");
  });

  testWidgets("DynamicText clears value", (tester) async {
    late Map<String, String> result;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
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
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));
    textState.widget.clear();

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));
    state.submit();
    expect(result.length, 1, reason: "One text field should be rendered");
    expect(result["text"], "", reason: "Value was set");
  });

  testWidgets("DynamicText can be hidden", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
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

  testWidgets("DynamicText was enabled becomes disabled", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    expect(textState.widget.enabled.value, true);
    state.disableField("text");
    expect(textState.widget.enabled.value, false);
  });

  testWidgets("DynamicText was disabled becomes enabled", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              enabled: false,
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));

    expect(textState.widget.enabled.value, false, reason: "defaults to false");
    state.enableField("text");
    expect(textState.widget.enabled.value, true, reason: "was set to true");
  });

  testWidgets("DynamicText was visable becomes hidden", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));

    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));
    expect(find.byType(DynamicTextField), findsOneWidget);

    expect(textState.widget.hidden.value, false, reason: "defaults to false");
    state.hideField("text");
    expect(textState.widget.hidden.value, true, reason: "was set to true");

    await tester.pump();
    expect(find.byType(DynamicTextField), findsNothing);
  });
  testWidgets("DynamicText was hidden becomes visible", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DynamicForm(
          children: [
            DynamicTextModel(
              id: "text",
              label: "Name",
              hidden: true,
            ).asWidget(),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var state = tester.state<DynamicFormState>(find.byType(DynamicForm));

    expect(find.byType(DynamicTextField), findsNothing);

    state.showField("text");
    await tester.pump();
    var textState =
        tester.state<DynamicTextFieldState>(find.byType(DynamicTextField));
    expect(textState.widget.hidden.value, false, reason: "was set to true");

    expect(find.byType(DynamicTextField), findsOneWidget);
  });
}
