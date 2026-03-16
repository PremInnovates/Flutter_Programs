import 'package:flutter/material.dart';
import 'package:task5/screens/attendance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Tracker',  
      home: Attendance(),
    );
  }
}
