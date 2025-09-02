import 'package:auto_form_plus/src/form/auto_form.dart';
import 'package:flutter/material.dart';

class RegisterFormExample extends StatelessWidget {
  const RegisterFormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Form'),
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
            ),
            AutoTextField(
              id: "email",
              label: "Email",
              validations: [
                RequiredValidation(),
                RegexValidation(
                  value: r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                  errorMessage: "Invalid email address",
                ),
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
            AutoTextField(
              id: "confirm_password",
              label: "Confirm Password",
              obscure: true,
              validations: [
                RequiredValidation(),
                EqualsValidation(
                    value: "@password", errorMessage: "Passwords must match")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
