import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({super.key});

  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  @override
  Widget build(BuildContext context) {
    List<String> names = ['A', 'B', 'C', 'D', 'E'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Demo'),
      ),
      body: ListView.separated(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(names[index]),
            leading: CircleAvatar(
              child: Text(names[index].substring(0, 1).toUpperCase()),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}