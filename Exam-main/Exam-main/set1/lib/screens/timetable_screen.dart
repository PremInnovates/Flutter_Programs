import 'package:flutter/material.dart';
import 'package:set1/models/session.dart';
import 'add_session_screen.dart';
import 'summary_screen.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  List<Session> sessions = [];

  // ADD SESSION
  void _addSession() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddSessionScreen()),
    );

    if (result != null) {
      setState(() {
        sessions.add(result);
      });
    }
  }

  // DELETE
  void _deleteSession(int index) {
    setState(() {
      sessions.removeAt(index);
    });
  }

  // EDIT
  void _editSession(int index) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddSessionScreen(session: sessions[index]),
      ),
    );

    if (updated != null) {
      setState(() {
        sessions[index] = updated;
      });
    }
  }

  // GROUP BY DAY
  Map<String, List<Session>> get groupedSessions {
    Map<String, List<Session>> map = {};
    for (var s in sessions) {
      map.putIfAbsent(s.day, () => []);
      map[s.day]!.add(s);
    }
    return map;
  }

  // SUMMARY DATA
  Map<String, int> get sessionsPerDay {
    Map<String, int> data = {};
    for (var s in sessions) {
      data[s.day] = (data[s.day] ?? 0) + 1;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SummaryScreen(
                    totalSessions: sessions.length,
                    sessionsPerDay: sessionsPerDay,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addSession,
        child: Icon(Icons.add),
      ),

      body: ListView(
        children: groupedSessions.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  entry.key,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              ...entry.value.asMap().entries.map((e) {
                int index = sessions.indexOf(e.value);

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(e.value.subject),
                    subtitle: Text(e.value.time),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editSession(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteSession(index),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }).toList(),
      ),
    );
  }
}
