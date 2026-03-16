import 'package:flutter/material.dart';
import 'package:task5/screens/add_student_screen.dart';
import 'package:task5/screens/summary_screen.dart';


class Attendance extends StatelessWidget {
  const Attendance({super.key});

  final List<String> students = [];              // ❌ BUG 1
  final Map<String, bool> attendance = {};       // ❌ BUG 1

  int presentCount = 0;                          // ❌ BUG 1

  void addStudent(String name) {
    students.add(name);
    attendance[name] = false;

    presentCount =
        attendance.values.where((value) => value = true).length; // ❌ BUG 2
  }

  void toggleAttendance(String name) {
    attendance[name] != attendance[name]; // ❌ BUG 3
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SummaryScreen(
                    presentCount: presentCount,   // ❌ BUG 4
                    totalStudents: students.length,
                  ),
                ),
              );
            },
          )
        ],
      ),

      body: Column(
        children: [

          Text("Present: $presentCount"), // ❌ BUG 5

          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {

                String name = students[index];

                return ListTile(
                  title: Text(name),

                  trailing: Checkbox(
                    value: attendance[name],
                    onChanged: (value) {
                      toggleAttendance(name); // ❌ BUG 6
                    },
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () async {

              final newStudent = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddStudentScreen(),
                ),
              );

              addStudent(newStudent); // ❌ BUG 7
            },
            child: const Text("Add Student"),
          )
        ],
      ),
    );
  }
}

