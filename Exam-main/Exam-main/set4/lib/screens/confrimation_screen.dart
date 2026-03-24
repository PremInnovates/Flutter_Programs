import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  final String slotTime;

  const ConfirmationScreen({super.key, required this.slotTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Slot Booked:",
              style: TextStyle(fontSize: 20),
            ),

            Text(
              slotTime,
              style: TextStyle(fontSize: 30),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // FIX: no need to return value
              },
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}