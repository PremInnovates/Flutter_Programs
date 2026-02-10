import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

//////////////////////////////////////////////////////////
// 1️⃣ LOGIN PAGE
//////////////////////////////////////////////////////////
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
  }

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");
    String? savedName = prefs.getString("name");

    if (emailCtrl.text == savedEmail && passwordCtrl.text == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => ProductList(username: savedName ?? "User")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("❌ Invalid Email or Password",
              style: TextStyle(fontWeight: FontWeight.bold))));
    }
  }

  void handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", account.displayName ?? "User");
        await prefs.setString("email", account.email);
        await prefs.setString("password", "google_signin");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ProductList(username: account.displayName ?? "User")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Google Sign-In Failed: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg_light.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Light Purple Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0.25),
                  Colors.deepPurpleAccent.withOpacity(0.25)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/AGS.png",
                      height: 120,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 14,
                              spreadRadius: 2)
                        ],
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailCtrl,
                            decoration: fieldStyle("Email"),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passwordCtrl,
                            obscureText: true,
                            decoration: fieldStyle("Password"),
                          ),
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              onPressed: login,
                              child: const Text("Login"),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: Image.asset(
                                "assets/icons/google.png",
                                height: 24,
                                width: 24,
                              ),
                              label: const Text("Continue with Google"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              onPressed: handleGoogleSignIn,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                        const RegistrationPage()));
                              },
                              child: const Text(
                                "Don't have an account? Register",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ---------------------------------------------------
// Registration Page
// ---------------------------------------------------

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isFormValid = false;
  String? selectedGender;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void checkForm() {
    setState(() {
      isFormValid = nameCtrl.text.isNotEmpty &&
          emailCtrl.text.contains("@") &&
          passwordCtrl.text.length >= 6 &&
          mobileCtrl.text.length == 10 &&
          selectedGender != null;
    });
  }

  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    );
  }

  void handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", account.displayName ?? "User");
        await prefs.setString("email", account.email);
        await prefs.setString("password", "google_signin");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ProductList(username: account.displayName ?? "User")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Google Sign-In Failed: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/images/AGS.png",
                height: 120,
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: fieldStyle("Full Name"),
                      onChanged: (_) => checkForm(),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: emailCtrl,
                      decoration: fieldStyle("Email"),
                      onChanged: (_) => checkForm(),
                    ),
                    const SizedBox(height: 18),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      decoration: fieldStyle("Gender"),
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(value: "Female", child: Text("Female")),
                        DropdownMenuItem(
                            value: "Not Prefer",
                            child: Text("Prefer not to say")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                          checkForm();
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: mobileCtrl,
                      decoration: fieldStyle("Mobile Number"),
                      keyboardType: TextInputType.phone,
                      onChanged: (_) => checkForm(),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: true,
                      decoration: fieldStyle("Password"),
                      onChanged: (_) => checkForm(),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isFormValid
                            ? () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setString("name", nameCtrl.text);
                          await prefs.setString("email", emailCtrl.text);
                          await prefs.setString(
                              "password", passwordCtrl.text);
                          await prefs.setString("mobile", mobileCtrl.text);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OTPVerificationPage(
                                      mobile: mobileCtrl.text)));
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFormValid
                              ? Colors.deepPurple
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------
// OTP Verification Page
// ---------------------------------------------------

class OTPVerificationPage extends StatefulWidget {
  final String mobile;
  const OTPVerificationPage({super.key, required this.mobile});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController otpCtrl = TextEditingController();
  String generatedOTP = "";

  @override
  void initState() {
    super.initState();
    generatedOTP = (100000 +
        (999999 - 100000) *
            (DateTime.now().millisecondsSinceEpoch % 1000) /
            1000)
        .toInt()
        .toString();
    print("Generated OTP for ${widget.mobile}: $generatedOTP");
  }

  void verifyOTP() async {
    if (otpCtrl.text == generatedOTP) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedName = prefs.getString("name");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => ProductList(username: savedName ?? "User")),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("❌ Invalid OTP. Try again.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg_light.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.deepPurple.withOpacity(0.7),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter the OTP sent to ${widget.mobile}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: otpCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "OTP",
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: verifyOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text("Verify OTP"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////
// 4️⃣ PRODUCT LIST / E-COMMERCE SCREEN
//////////////////////////////////////////////////////////
Future<List<dynamic>> loadProducts() async {
  final String response = await rootBundle.loadString('assets/db.json');
  return json.decode(response);
}

class ProductList extends StatelessWidget {
  final String username;
  const ProductList({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        backgroundColor: Colors.deepPurple,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("🛍 My Stationary Shop",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white)),
            Text("Hello, $username 👋",
                style: const TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: FutureBuilder<List<dynamic>>(
        future: loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            spreadRadius: 2)
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(product['image'],
                                fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(product['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 4),
                              Text("₹${product['price']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple)),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.deepPurple,
                                        content: Text(
                                            "${product['name']} added to cart!",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                    );
                                  },
                                  child: const Text("Buy Now",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}