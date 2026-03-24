import 'package:flutter/material.dart';
import 'package:set4/screens/slot_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Set 4',
      debugShowCheckedModeBanner: false,
      home: SlotScreen(),
    );
  }
}
