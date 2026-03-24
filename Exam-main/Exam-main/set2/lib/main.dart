import 'package:flutter/material.dart';
import 'package:set2/screens/feedback_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback System',
      debugShowCheckedModeBanner: false,

      //  ADDED: Theme for better UI consistency
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // modern UI
      ),

      //  ADDED: Named routes (useful for navigation scaling)
      routes: {
        '/': (context) => const FeedbackFormScreen(),
      },

      //  FIX (minor improvement): use initialRoute instead of home
      initialRoute: '/',
    );
  }
}