import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  final Function(String) addStudent;
  const AddStudentScreen(this.addStudent, {super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final controller = TextEditingController();

  void save() {
    final name = controller.text.trim();
    if (controller.text.isNotEmpty) {
      widget.addStudent(name);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Student")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter Student Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
