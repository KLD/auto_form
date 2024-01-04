import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_trigger.dart';
import 'package:auto_form/form/abstract/trigger_event.dart';
import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_text_field.dart';

void main() {
  testWidgets("AutoText trigger hide", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
              key: text1Key,
              id: "text_1",
              label: "First Name",
              triggers: const [
                FieldTrigger.other(
                  fieldId: "text_2",
                  value: "Khaled",
                  condition: EqualsCondition(),
                  event: HideEvent(),
                ),
              ],
            ),
            AutoTextField(
              key: text2Key,
              id: "text_2",
              label: "Last Name",
            ),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsNWidgets(2));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));
    expect(text2State.widget.isHidden.value, false,
        reason: "Should be visibale");

    text1State.widget.setValue("Khaled");
    await tester.pump();

    expect(text2State.widget.isHidden.value, true,
        reason: "Should be hidden from trigger");
    expect(find.byType(TextFormField), findsOneWidget);

    text1State.widget.setValue("");
    await tester.pump();

    expect(text2State.widget.isHidden.value, false,
        reason: "Should be visibale from trigger");
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets("AutoText trigger show", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
                id: "text_1",
                label: "First Name",
                triggers: const [
                  FieldTrigger.other(
                    fieldId: "text_2",
                    value: "Khaled",
                    condition: EqualsCondition(),
                    event: ShowEvent(),
                  ),
                ],
                key: text1Key),
            AutoTextField(
                id: "text_2", label: "Last Name", hidden: true, key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsOneWidget);

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));

    text1State.widget.setValue("Khaled");

    await tester.pump();

    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));
    expect(text2State.widget.isHidden.value, false,
        reason: "Should be visibale");

    expect(find.byType(TextFormField), findsNWidgets(2));

    text1State.widget.setValue("");
    await tester.pump();

    expect(text2State.widget.isHidden.value, true,
        reason: "Should be hidden from trigger");
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets("AutoText trigger disable", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
                id: "text_1",
                label: "First Name",
                triggers: const [
                  FieldTrigger.other(
                    fieldId: "text_2",
                    value: "Khaled",
                    condition: EqualsCondition(),
                    event: DisableEvent(),
                  ),
                ],
                key: text1Key),
            AutoTextField(id: "text_2", label: "Last Name", key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    expect(text2State.widget.isEnabled.value, true,
        reason: "Should be enabled before trigger");
    text1State.widget.setValue("Khaled");

    await tester.pump();

    expect(text2State.widget.isEnabled.value, false,
        reason: "Should be disabled");

    text1State.widget.setValue("");
    await tester.pump();

    expect(text2State.widget.isEnabled.value, true,
        reason: "Should be enabled after trigger");
  });

  testWidgets("AutoText trigger enable", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
                id: "text_1",
                label: "First Name",
                triggers: const [
                  FieldTrigger.other(
                    fieldId: "text_2",
                    value: "Khaled",
                    condition: EqualsCondition(),
                    event: EnableEvent(),
                  ),
                ],
                key: text1Key),
            AutoTextField(
                id: "text_2",
                label: "Last Name",
                enabled: false,
                key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    expect(text2State.widget.isEnabled.value, false,
        reason: "Should be disabled bedfore trigger");

    text1State.widget.setValue("Khaled");
    await tester.pump();

    expect(text2State.widget.isEnabled.value, true,
        reason: "Should be enabled");

    text1State.widget.setValue("");
    await tester.pump();

    expect(text2State.widget.isEnabled.value, false,
        reason: "Should be disabled after trigger");
  });

  testWidgets("AutoText trigger clear", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
                id: "text_1",
                label: "First Name",
                triggers: [
                  FieldTrigger.other(
                    fieldId: "text_2",
                    value: "Khaled",
                    condition: const EqualsCondition(),
                    event: ClearEvent(),
                  ),
                ],
                key: text1Key),
            AutoTextField(
                id: "text_2",
                label: "Last Name",
                initValue: "some value",
                key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var form = tester.state<AutoFormState>(find.byType(AutoForm));
    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    expect(text2State.widget.value.isNotEmpty, true,
        reason: "Should be initValue");
    form.setValue("text_1", "Khaled");

    await tester.pump();

    expect(text2State.widget.value.isEmpty, true, reason: "Should be empty");

    text1State.widget.setValue("");
    await tester.pump();

    expect(text2State.widget.value.isEmpty, true,
        reason: "Should still be empty");
  });

  testWidgets("AutoText trigger clear on initValue", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextField(
                key: text1Key,
                id: "text_1",
                label: "First Name",
                initValue: "Khaled",
                triggers: [
                  FieldTrigger.other(
                    fieldId: "text_2",
                    value: "Khaled",
                    condition: const EqualsCondition(),
                    event: ClearEvent(),
                  ),
                ]),
            AutoTextField(
                key: text2Key,
                id: "text_2",
                label: "Last Name",
                initValue: "some value"),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    await tester.pump();
    expect(text2State.widget.value.isEmpty, true, reason: "Should be empty");
  });
}
