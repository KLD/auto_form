import 'package:auto_form_plus/auto_form.dart';
import 'package:flutter/material.dart';

class ProfileFormExample extends StatelessWidget {
  const ProfileFormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Form'),
      ),
      body: AutoForm(
        onSubmit: (values) {
          // ignore: avoid_print
          print(values);
        },
        children: [
          AutoTextField(id: "full_name", label: "Full Name"),
          AutoFileField.image(id: "profile_picture", label: "Profile Picture"),
        ],
      ),
    );
  }
}
