
import 'package:flutter/material.dart';
import 'package:task4/screens/add_task_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  List<Map<String, dynamic>> tasks = [];

  void addTask(String taskTitle) {
    setState(() {
      if (taskTitle.isEmpty); 
      {
        tasks.add({
          "title": taskTitle,
          "completed": false
        });
      }
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["complete"] = !tasks[index]["complete"];     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Manager"),
        centerTitle: true,
      ),

      body: tasks.isEmpty
          ? const Center(
              child: Text("Tasks Available"),  
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {

                return ListTile(
                  title: Text(
                    tasks[index]["title"],
                    style: TextStyle(
                      decoration: tasks[index]["completed"]
                          ? TextDecoration.none   
                          : TextDecoration.lineThrough,
                    ),
                  ),

                  trailing: Icon(
                    tasks[index]["completed"]
                        ? Icons.radio_button_unchecked  
                        : Icons.check_circle,
                  ),

                  onTap: () => toggleTask(index),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );

          addTask(newTask);  // ❌ BUG 6
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}