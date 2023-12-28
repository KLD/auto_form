// import 'package:flutter/material.dart';

// import '../abstract/auto_field_model.dart';
// import '../abstract/auto_field_widget.dart';

// class AutoCheckboxModel extends AutoFieldInterface {
//   AutoCheckboxModel({
//     required super.id,
//     required super.label,
//     super.isEnabled = true,
//     super.hidden = false,
//     super.required = false,
//     super.validations = const [],
//     super.triggers = const [],
//   });

//   @override
//   AutoFieldWidget asWidget({Key? key}) =>
//       DynamicCheckboxField(model: this, key: key);
// }

// class DynamicCheckboxField extends AutoFieldWidget<AutoCheckboxModel> {
//   DynamicCheckboxField({
//     required super.model,
//     super.key,
//   });

//   @override
//   State<AutoFieldWidget> createState() => _DynamicCheckboxFieldState();
// }

// class _DynamicCheckboxFieldState extends State<DynamicCheckboxField> {
//   bool _value = false;

//   @override
//   void initState() {
//     super.initState();

//     widget.setValue((widget.model.initValue == true.toString()).toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//         value: widget.value == true.toString(),
//         title: Text(widget.model.label),
//         enabled: widget.isEnabled.value,
//         controlAffinity: ListTileControlAffinity.leading,
//         onChanged: (_) {
//           setState(() {
//             _value = !_value;
//             widget.setValue(_value.toString());
//           });
//         });
//   }
// }
