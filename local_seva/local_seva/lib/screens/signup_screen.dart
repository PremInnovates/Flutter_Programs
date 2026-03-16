import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF6B8DD6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo/Icon Section
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.white, Color(0xFFE3F2FD)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_add_alt_1_rounded,
                              size: 70,
                              color: Color(0xFF1E3C72),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Welcome Text with Animation
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Column(
                              children: [
                                const Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Sign up to get started",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.9),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Main Card with Form
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOut,
                      builder: (context, double value, child) {
                        return Transform.translate(
                          offset: Offset(0, 50 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    // Full Name Field
                                    TextField(
                                      controller: fullNameController,
                                      style: const TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        labelText: "Full Name",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          child: Icon(
                                            Icons.person_outline_rounded,
                                            color: const Color(0xFF1E3C72),
                                            size: 22,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Email Field
                                    TextField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        labelText: "Email Address",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          child: Icon(
                                            Icons.email_outlined,
                                            color: const Color(0xFF1E3C72),
                                            size: 22,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Password Field
                                    TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      style: const TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          child: Icon(
                                            Icons.lock_outline_rounded,
                                            color: const Color(0xFF1E3C72),
                                            size: 22,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed: () {
                                            // Toggle password visibility
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Confirm Password Field
                                    TextField(
                                      controller: confirmPasswordController,
                                      obscureText: true,
                                      style: const TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        labelText: "Confirm Password",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          child: Icon(
                                            Icons.lock_outline_rounded,
                                            color: const Color(0xFF1E3C72),
                                            size: 22,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed: () {
                                            // Toggle password visibility
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 16,
                                            ),
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // Terms and Conditions
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1.2,
                                          child: Checkbox(
                                            value: true,
                                            onChanged: (value) {
                                              // Handle terms acceptance
                                            },
                                            activeColor: const Color(
                                              0xFF1E3C72,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              text: "I agree to the ",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: "Terms of Service",
                                                  style: const TextStyle(
                                                    color: Color(0xFF1E3C72),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " and ",
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Privacy Policy",
                                                  style: const TextStyle(
                                                    color: Color(0xFF1E3C72),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 25),

                                    // Register Button with Gradient
                                    Container(
                                      width: double.infinity,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF1E3C72),
                                            Color(0xFF2A5298),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFF1E3C72,
                                            ).withOpacity(0.3),
                                            blurRadius: 15,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Registration logic here
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Account created successfully!',
                                              ),
                                              backgroundColor: Colors.green,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Create Account",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 25),

                                    // OR Divider
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            "OR",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 25),

                                    // Social Sign Up Buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildSocialButton(
                                          icon: Icons.g_mobiledata,
                                          color: Colors.red,
                                          onPressed: () {},
                                        ),
                                        _buildSocialButton(
                                          icon: Icons.facebook,
                                          color: Colors.blue,
                                          onPressed: () {},
                                        ),
                                        _buildSocialButton(
                                          icon: Icons.apple,
                                          color: Colors.black,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
