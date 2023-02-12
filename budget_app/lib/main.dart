import 'package:budget_app/homepage.dart';
import 'package:flutter/material.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 116, 175, 209)),
      ),
      home: HomePage(),
    );
  }
}
