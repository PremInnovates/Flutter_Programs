import 'package:flutter/material.dart';
import 'payment_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking")),

      body: Center(
        child: ElevatedButton(
          child: Text("Proceed to Payment"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentScreen()),
            );
          },
        ),
      ),
    );
  }
}
