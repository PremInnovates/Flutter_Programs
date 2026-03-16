import 'package:flutter/material.dart';
import 'package:task6/screens/token_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'task6',
       home: TokenScreen(),
    );
  }
}


