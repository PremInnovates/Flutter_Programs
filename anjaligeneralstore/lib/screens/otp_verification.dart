import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anjaligeneralstore/screens/productlist.dart';

class OTPPage extends StatefulWidget {
  final String mobile;
  const OTPPage({super.key, required this.mobile});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpCtrl = TextEditingController();
  String otp = "123456"; // simple demo OTP

  void verify() async {
    if (otpCtrl.text == otp) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? name = prefs.getString("name");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => ProductList(username: name ?? "User")),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("OTP sent to ${widget.mobile}"),
          TextField(controller: otpCtrl),
          ElevatedButton(
            onPressed: verify,
            child: const Text("Verify"),
          )
        ],
      ),
    );
  }
}
