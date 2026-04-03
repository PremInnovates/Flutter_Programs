import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anjaligeneralstore/screens/otp_verification.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool isValid = false;

  void checkForm() {
    setState(() {
      isValid = nameCtrl.text.isNotEmpty &&
          emailCtrl.text.contains("@") &&
          mobileCtrl.text.length == 10 &&
          passwordCtrl.text.length >= 6;
    });
  }

  void register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", nameCtrl.text);
    await prefs.setString("email", emailCtrl.text);
    await prefs.setString("password", passwordCtrl.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OTPPage(mobile: mobileCtrl.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameCtrl, onChanged: (_) => checkForm()),
            TextField(controller: emailCtrl, onChanged: (_) => checkForm()),
            TextField(controller: mobileCtrl, onChanged: (_) => checkForm()),
            TextField(controller: passwordCtrl, onChanged: (_) => checkForm()),
            ElevatedButton(
              onPressed: isValid ? register : null,
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
