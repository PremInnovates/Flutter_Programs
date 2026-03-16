import 'package:flutter/material.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter Student Name",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller); // ❌ BUG 8
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
