import 'package:flutter/material.dart';
import 'package:task3/screens/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task3',
      debugShowCheckedModeBanner: false,
      home: ProductsScreen()
    );
  }
}

