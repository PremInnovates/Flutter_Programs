import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Success")),

      body: Center(
        child: Text(
          "Booking Successful!",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}