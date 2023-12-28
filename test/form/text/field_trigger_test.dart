import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_form/form/abstract/condition.dart';
import 'package:auto_form/form/abstract/field_trigger.dart';
import 'package:auto_form/form/abstract/trigger_event.dart';
import 'package:auto_form/form/auto_form.dart';
import 'package:auto_form/form/widgets/auto_text_model.dart';

void main() {
  testWidgets("AutoText trigger hide", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text_1", label: "First Name", triggers: [
              const FieldTrigger(
                fieldId: "text_2",
                value: "Khaled",
                condition: EqualsCondition(),
                event: HideEvent(),
              ),
            ]).asWidget(key: text1Key),
            AutoTextModel(id: "text_2", label: "Last Name")
                .asWidget(key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    expect(find.byType(TextFormField), findsNWidgets(2));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));
    expect(text2State.widget.hidden.value, false, reason: "Should be visibale");

    text1State.widget.setValue("Khaled");
    await tester.pump();

    expect(text2State.widget.hidden.value, true,
        reason: "Should be hidden from trigger");
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets("AutoText trigger show", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text_1", label: "First Name", triggers: [
              const FieldTrigger(
                fieldId: "text_2",
                value: "Khaled",
                condition: EqualsCondition(),
                event: ShowEvent(),
              ),
            ]).asWidget(key: text1Key),
            AutoTextModel(id: "text_2", label: "Last Name", hidden: true)
                .asWidget(key: text2Key),
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
    expect(text2State.widget.hidden.value, false, reason: "Should be visibale");

    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets("AutoText trigger disable", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text_1", label: "First Name", triggers: [
              const FieldTrigger(
                fieldId: "text_2",
                value: "Khaled",
                condition: EqualsCondition(),
                event: DisableEvent(),
              ),
            ]).asWidget(key: text1Key),
            AutoTextModel(id: "text_2", label: "Last Name")
                .asWidget(key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    expect(text2State.widget.enabled.value, true,
        reason: "Should be enabled before trigger");
    text1State.widget.setValue("Khaled");

    await tester.pump();

    expect(text2State.widget.enabled.value, false,
        reason: "Should be disabled");
  });

  testWidgets("AutoText trigger enable", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text_1", label: "First Name", triggers: [
              const FieldTrigger(
                fieldId: "text_2",
                value: "Khaled",
                condition: EqualsCondition(),
                event: EnableEvent(),
              ),
            ]).asWidget(key: text1Key),
            AutoTextModel(id: "text_2", label: "Last Name", enabled: false)
                .asWidget(key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    expect(text2State.widget.enabled.value, false,
        reason: "Should be disabled bedfore trigger");
    text1State.widget.setValue("Khaled");

    await tester.pump();

    expect(text2State.widget.enabled.value, true, reason: "Should be enabled");
  });

  testWidgets("AutoText trigger clear", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(id: "text_1", label: "First Name", triggers: [
              FieldTrigger(
                fieldId: "text_2",
                value: "Khaled",
                condition: const EqualsCondition(),
                event: ClearEvent(),
              ),
            ]).asWidget(key: text1Key),
            AutoTextModel(
                    id: "text_2", label: "Last Name", initValue: "some value")
                .asWidget(key: text2Key),
          ],
          onSubmit: (data) {},
        ),
      ),
    ));

    var text1State = tester.state<AutoTextFieldState>(find.byKey(text1Key));
    var text2State = tester.state<AutoTextFieldState>(find.byKey(text2Key));

    expect(text2State.widget.value.isNotEmpty, true,
        reason: "Should be initValue");
    text1State.widget.setValue("Khaled");

    await tester.pump();

    expect(text2State.widget.value.isEmpty, true, reason: "Should be empty");
  });

  testWidgets("AutoText trigger clear on initValue", (tester) async {
    var text1Key = GlobalKey();
    var text2Key = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AutoForm(
          children: [
            AutoTextModel(
                id: "text_1",
                label: "First Name",
                initValue: "Khaled",
                triggers: [
                  FieldTrigger(
                    fieldId: "text_2",
                    value: "Khaled",
                    condition: const EqualsCondition(),
                    event: ClearEvent(),
                  ),
                ]).asWidget(key: text1Key),
            AutoTextModel(
                    id: "text_2", label: "Last Name", initValue: "some value")
                .asWidget(key: text2Key),
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
