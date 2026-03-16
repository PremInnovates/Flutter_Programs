import 'package:flutter/material.dart';

import 'package:local_seva/screens/splash_screen.dart';

void main() {
  runApp(const LocalSevaApp());
}

class LocalSevaApp extends StatelessWidget {
  const LocalSevaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Seva',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}
