import 'package:flutter/material.dart';
import 'package:feb10_circleavatar_list/app_scaffold.dart';
import 'package:feb10_circleavatar_list/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // <-- This removes the debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      mychildren: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Home Page"),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewDemo()),
                );
              },
              child: const Text("Go"),
            ),
          ],
        ),
      ),
    );
  }
}
