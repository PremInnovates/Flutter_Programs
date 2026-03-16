import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int finalScore; // 😈 BUG (never initialized)
  const ResultScreen({super.key, required this.finalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Result")),
      body: Center(
        child: Text(
          "Score: $finalScore",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}