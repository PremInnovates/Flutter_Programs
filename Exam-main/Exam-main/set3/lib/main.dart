import 'package:flutter/material.dart';
import 'package:set3/screens/inventory_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Set 3 Inventory',
      debugShowCheckedModeBanner: false,
      home: InventoryScreen(),
    );
  }
}