import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final int totalTokens;
  final int queueLength;
 const SummaryScreen({super.key, required this.totalTokens,
    required this.queueLength});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Queue Summary")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Tokens Generated: $totalTokens",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Pending Queue: $queueLength",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}