import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final controller = TextEditingController();

  void saveTask() {

    if (controller.text.isEmpty) {
      Navigator.pop(context); 
    }

    Navigator.pop(context, controller); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter Task",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveTask,
              child: const Text("Save Task"),
            )
          ],
        ),
      ),
    );
  }
}
