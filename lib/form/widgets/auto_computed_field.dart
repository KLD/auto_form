import 'package:auto_form/form/abstract/auto_field_state.dart';

import '../abstract/comparor.dart';
import '../abstract/detect_value_type.dart';
import 'package:flutter/material.dart';

import '../abstract/auto_field_widget.dart';

class AutoComputedField extends AutoFieldWidget {
  final List<String> fields;
  final ComputeOperation operation;

  AutoComputedField({
    super.key,
    required super.id,
    super.label = "",
    required this.fields,
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
    for (var fieldId in widget.fields) {
      if (fieldId.startsWith("@")) {
        fieldId = fieldId.substring(1);
        var fieldValue = widget.form.fields[fieldId]!;

        fieldValue.onValueSet.add((v) {
          updateComputedValue();
        });
      }
    }
  }

  void updateComputedValue() {
    var firstValue = widget.form.resolveValue(widget.fields.first);

    var totalValue = firstValue;

    for (var field in widget.fields.skip(1)) {
      var fieldValue = widget.form.resolveValue(field);

      try {
        totalValue = widget.operation.compute(totalValue, fieldValue);
      } on String {
        totalValue = "";
      }
    }

    widget.setValue(totalValue);
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
  String compute(String a, String b) {
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
      computer.format(computer.add(a, b));
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
      computer.format(computer.subtract(a, b));
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
