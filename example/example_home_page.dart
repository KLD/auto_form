import 'package:flutter/material.dart';

import 'forms/login_form_example.dart';
import 'forms/profile_form_example.dart';
import 'forms/register_form_example.dart';

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  // Define the list of form navigation items
  static final List<(String label, Widget)> _formItems = [
    ('Login Form', LoginFormExample()),
    ('Register Form', RegisterFormExample()),
    ('Profile Form', ProfileFormExample()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Form Plus'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Forms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ..._formItems.map((item) => ListTile(
                  title: Text(item.$1),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => item.$2,
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Example Home",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              "Use the drawer to navigate to forms",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
