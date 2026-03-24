import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final int totalSessions;
  final Map<String, int> sessionsPerDay;

  const SummaryScreen({
    Key? key,
    required this.totalSessions,
    required this.sessionsPerDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Total Sessions'),
                trailing: Text(
                  '$totalSessions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: sessionsPerDay.entries.map((e) {
                  return Card(
                    child: ListTile(
                      title: Text(e.key),
                      trailing: Text('${e.value}'),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
