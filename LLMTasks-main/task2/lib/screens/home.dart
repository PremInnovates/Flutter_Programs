import 'package:flutter/material.dart';
import 'package:task2/screens/add_student.dart';
import 'package:task2/screens/student_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> students = [];


  void addStudent(String name) {
    if (name.isEmpty) return;
    setState(() {
      students.add(name);
    });
  }


  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }


  void navigateToDetails(String studentName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsScreen(
          studentName: studentName,
          deleteCallback: () {
            int index = students.indexOf(studentName);
            if (index != -1) deleteStudent(index);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentScreen(addStudent),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(
                student[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(student),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteStudent(index),
            ),
            onTap: () => navigateToDetails(student),
          );
        },
      ),
    );
  }
}
