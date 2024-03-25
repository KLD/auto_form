import 'package:flutter/material.dart';
import 'pages/baisc_fields_page.dart';

void main() {
  runApp(const GroupExampleApp());
}

class GroupExampleApp extends StatelessWidget {
  const GroupExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Example Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: BasicFieldsPage(),
      ),
    );
  }
}
