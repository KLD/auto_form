import 'package:auto_form_plus/src/form/auto_form.dart';
import 'package:flutter/material.dart';

class LoginFormExample extends StatelessWidget {
  const LoginFormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AutoForm(
          onSubmit: (v) {
            // ignore: avoid_print
            print(v);
          },
          children: [
            AutoTextField(
              id: "username",
              label: "Username",
              validations: [
                RequiredValidation(),
              ],
            ),
            AutoTextField(
              id: "password",
              label: "Password",
              obscure: true,
              validations: [
                RequiredValidation(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
