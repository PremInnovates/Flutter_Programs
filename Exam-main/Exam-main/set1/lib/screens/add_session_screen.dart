import 'package:flutter/material.dart';
import 'package:set1/models/session.dart';

class AddSessionScreen extends StatefulWidget {
  final Session? session;

  const AddSessionScreen({Key? key, this.session}) : super(key: key);

  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _subject;
  String? _time;
  String? _day;

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final List<String> _times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _subject = widget.session?.subject;
    _time = widget.session?.time;
    _day = widget.session?.day;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Session newSession = Session(
        subject: _subject!,
        day: _day!,
        time: _time!,
      );

      Navigator.pop(context, newSession); // 🔥 IMPORTANT
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session == null ? 'Add Session' : 'Edit Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _day,
                decoration: InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                ),
                items: _days
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (val) => setState(() => _day = val),
                validator: (val) => val == null ? 'Select day' : null,
              ),

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _time,
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                items: _times
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => _time = val),
                validator: (val) => val == null ? 'Select time' : null,
              ),

              SizedBox(height: 10),

              TextFormField(
                initialValue: _subject,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Enter subject' : null,
                onSaved: (val) => _subject = val,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveForm,
                child: Text(widget.session == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
