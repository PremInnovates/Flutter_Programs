import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final int presentCount;
  final int totalStudents;

  const SummaryScreen({
    super.key,
    required this.presentCount,
    required this.totalStudents,
  });

  @override
  Widget build(BuildContext context) {

    int absentCount = totalStudents - presentCount;

    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Total Students: $totalStudents"),
            Text("Present Students: $presentCount"),
            Text("Absent Students: $absentCount"),

          ],
        ),
      ),
    );
  }
}
