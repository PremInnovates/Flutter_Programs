import 'package:flutter/material.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("My Bookings")),

      body: ListTile(
        title: Text("Plumber Service"),
        subtitle: Text("12 Feb 2026 • 10:00 AM"),
      ),
    );
  }
}