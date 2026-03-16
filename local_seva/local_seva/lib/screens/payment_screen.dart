import 'package:flutter/material.dart';
import 'booking_success_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Payment")),

      body: Center(
        child: ElevatedButton(
          child: Text("Pay ₹299"),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=>BookingSuccessScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}