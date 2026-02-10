import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Use Scaffold instead of AppScaffold
      body: Column(
        children: [
          Text("Home Page"),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListViewDemo()),
              );
            },
            child: Text("Go"),
          ),
        ],
      ),
    );
  }
}

// Make sure to define ListViewDemo widget elsewhere in your code
class ListViewDemo extends StatelessWidget {
  const ListViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for ListViewDemo content
    return Scaffold(
      appBar: AppBar(title: Text("ListView Demo")),
      body: ListView(
        children: [
          ListTile(title: Text("Item 1")),
          ListTile(title: Text("Item 2")),
        ],
      ),
    );
  }
}