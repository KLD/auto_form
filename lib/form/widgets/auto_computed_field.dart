import 'package:auto_form/form/abstract/auto_field_state.dart';

import '../abstract/comparor.dart';
import '../abstract/detect_value_type.dart';
import '../auto_form.dart';
import 'package:flutter/material.dart';

import '../abstract/auto_field_widget.dart';

class AutoComputedField extends AutoFieldWidget {
  final String fieldIdA;
  final String fieldIdB;
  final ComputeOperation operation;

  AutoComputedField({
    super.key,
    required super.id,
    required super.label,
    required this.fieldIdA,
    required this.fieldIdB,
    required this.operation,
    super.enabled = true,
    super.validations = const [],
    super.hidden = true,
    super.triggers = const [],
  });

  @override
  State<StatefulWidget> createState() => _ComputedFieldWidgetState();
}

class _ComputedFieldWidgetState extends AutoFieldState<AutoComputedField> {
  @override
  void initState() {
    super.initState();

    attachValueListers();

    widget.onRefresh.value = () {
      updateComputedValue();
    };
  }

  void attachValueListers() {
    var targetIdA = widget.fieldIdA;
    var targetIdB = widget.fieldIdB;

    if (targetIdA.startsWith("@")) {
      targetIdA = targetIdA.substring(1);
      var fieldValueA = widget.form.fields[targetIdA]!;
      fieldValueA.onValueSet.add((v) {
        updateComputedValue();
      });
    }
    if (targetIdB.startsWith("@")) {
      targetIdB = targetIdB.substring(1);
      var fieldValueB = widget.form.fields[targetIdB]!;

      fieldValueB.onValueSet.add((v) {
        updateComputedValue();
      });
    }
  }

  void updateComputedValue() {
    var fieldValueA = widget.fieldIdA;
    var fieldValueB = widget.fieldIdB;

    if (fieldValueA.startsWith("@")) {
      fieldValueA = fieldValueA.substring(1);
      fieldValueA = widget.form.fields[fieldValueA]!.value;
    }
    if (fieldValueB.startsWith("@")) {
      fieldValueB = fieldValueB.substring(1);
      fieldValueB = widget.form.fields[fieldValueB]!.value;
    }

    if (fieldValueA.isEmpty || fieldValueB.isEmpty) {
      widget.setValue("");
      setState(() {});

      return;
    }

    widget.setValue(
        widget.operation.compute(widget.form, fieldValueA, fieldValueB));

    setState(() {});
  }

  @override
  Widget buildField(BuildContext context) => FormField(
        // validator: (v) => widget.fieldValidator(widget.value),
        builder: (FormFieldState state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputDecorator(
              decoration: InputDecoration(
                labelText: widget.label,
              ),
              child: Text(widget.value),
            ),
            if (state.hasError)
              Text(state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error))
          ],
        ),
      );
}

abstract class ComputeOperation {
  String compute(AutoForm form, String a, String b) {
    var typeA = detectValueType(a);
    var typeB = detectValueType(b);

    // cascade to string
    if (typeA == ValueType.string || typeB == ValueType.string) {
      typeA = ValueType.string;
      typeB = ValueType.string;
    }

    if (typeA != typeB) {
      throw "Cannot compute different types, [$typeA] and [$typeB]";
    }

    var computer = defaultComparors[typeA]!;

    return operate(computer.parse(a), computer.parse(b), computer);
  }

  String operate(dynamic a, dynamic b, Comparor<dynamic> computer);
}

class AddOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) =>
      computer.add(a, b).toString();
}

class UpperCaseOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) =>
      ("$a $b").toUpperCase();
}

class LowerCaseOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) =>
      ("$a $b").toLowerCase();
}

class SubtractOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) =>
      computer.subtract(a, b).toString();
}

class MultiplyOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) =>
      computer.multiply(a, b).toString();
}

class DivideOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) =>
      computer.divide(a, b).toString();
}

class DiffInDaysOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) {
    if (a is DateTime && b is DateTime) {
      return b.difference(a).inDays.toString();
    }
    if (a is Duration && b is Duration) {
      return (b - a).inDays.toString();
    }

    throw "Cannot compute difference between dates, [$a] and [$b]";
  }
}

class DiffInHoursOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) {
    if (a is DateTime && b is DateTime) {
      return b.difference(a).inHours.toString();
    }
    if (a is Duration && b is Duration) {
      return (b - a).inHours.toString();
    }

    throw "Cannot compute difference between dates, [$a] and [$b]";
  }
}

class DiffInMinutesOperation extends ComputeOperation {
  @override
  String operate(dynamic a, dynamic b, Comparor<dynamic> computer) {
    if (a is DateTime && b is DateTime) {
      return b.difference(a).inMinutes.toString();
    }
    if (a is Duration && b is Duration) {
      return (b - a).inMinutes.toString();
    }

    throw "Cannot compute difference between dates, [$a] and [$b]";
  }
}
