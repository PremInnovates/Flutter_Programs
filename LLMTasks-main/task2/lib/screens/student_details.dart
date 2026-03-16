import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final String studentName;
  final VoidCallback? deleteCallback; // optional delete

  const StudentDetailsScreen({
    super.key,
    required this.studentName,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (deleteCallback != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: deleteCallback,
            ),
        ],
      ),
      body: Center(
        child: Text(
          "Student Name: $studentName",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
