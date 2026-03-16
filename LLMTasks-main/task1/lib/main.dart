import 'package:flutter/material.dart';
import 'package:task1/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task1',
      home:HomeScreen(),
    );
  }
}
