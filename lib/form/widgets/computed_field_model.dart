import '../abstract/detect_value_type.dart';
import '../dynamic_form.dart';
import 'package:flutter/material.dart';

import '../abstract/dynamic_comparor.dart';
import '../abstract/dynamic_field_model.dart';
import '../abstract/base_dynamic_field.dart';

class ComputedFieldModel extends DynamicFieldModel {
  final String fieldIdA;
  final String fieldIdB;

  final ComputeOperation operatoion;

  ComputedFieldModel(
    this.fieldIdA,
    this.fieldIdB, {
    required this.operatoion,
    required super.id,
    super.label = "",
    super.enabled = true,
    super.required = false,
    super.validations = const [],
    super.hidden = true,
    super.triggers = const [],
  });

  @override
  BaseDynamicField<DynamicFieldModel> asWidget({Key? key}) =>
      DynamicComputedField(model: this, key: key);
}

class DynamicComputedField extends BaseDynamicField<ComputedFieldModel> {
  DynamicComputedField({super.key, required super.model});

  @override
  State<StatefulWidget> createState() => _ComputedFieldWidgetState();
}

class _ComputedFieldWidgetState extends State<DynamicComputedField> {
  @override
  void initState() {
    super.initState();

    attachValueListers();

    widget.onRefresh.value = () {
      updateComputedValue();
    };
  }

  void attachValueListers() {
    var targetIdA = widget.model.fieldIdA;
    var targetIdB = widget.model.fieldIdB;

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
    var fieldValueA = widget.model.fieldIdA;
    var fieldValueB = widget.model.fieldIdB;

    if (fieldValueA.startsWith("@")) {
      fieldValueA = fieldValueA.substring(1);
      fieldValueA = widget.form.fields[fieldValueA]!.value;
    }
    if (fieldValueB.startsWith("@")) {
      fieldValueB = fieldValueB.substring(1);
      fieldValueB = widget.form.fields[fieldValueB]!.value;
    }

    if (fieldValueA.isEmpty || fieldValueB.isEmpty) {
      widget.clear();
      setState(() {});

      return;
    }

    widget.setValue(
        widget.model.operatoion.compute(widget.form, fieldValueA, fieldValueB));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => FormField(
        validator: (v) => widget.fieldValidator(widget.value),
        builder: (FormFieldState state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputDecorator(
              decoration: InputDecoration(
                labelText: widget.model.label,
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
  String compute(DynamicForm form, String a, String b) {
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

    var computer = comparors[typeA]!;

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
      a.toUpperCase() + " " + b.toString().toUpperCase();
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
