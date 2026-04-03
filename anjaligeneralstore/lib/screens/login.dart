import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:anjaligeneralstore/screens/productlist.dart';
import 'package:anjaligeneralstore/screens/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");
    String? savedName = prefs.getString("name");

    if (emailCtrl.text == savedEmail && passwordCtrl.text == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProductList(username: savedName ?? "User"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid Email or Password")),
      );
    }
  }

  void googleLogin() async {
    final account = await _googleSignIn.signIn();

    if (account != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("name", account.displayName ?? "User");
      await prefs.setString("email", account.email);
      await prefs.setString("password", "google");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProductList(username: account.displayName ?? "User"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: googleLogin,
              child: const Text("Google Sign-In"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegistrationPage()),
                );
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
