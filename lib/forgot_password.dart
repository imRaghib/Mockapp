import 'package:flutter/material.dart';
//import 'view/forgot_password_screen.dart';

void main() {
  runApp(const ForgotPasswordApp());
}

class ForgotPasswordApp extends StatelessWidget {
  const ForgotPasswordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      debugShowCheckedModeBanner: false,
      home: const ForgotPasswordScreen(),
    );
  }
}


/// File: view/forgot_password_screen.dart


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final viewModel = ForgotPasswordViewModel();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Column(
                  children: [
                    Icon(Icons.account_circle_outlined, size: 60, color: Colors.black87),
                    SizedBox(height: 8),
                    Text('HILTERMANN',
                      style: TextStyle(fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text('Forgot Password',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'Times New Roman', color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text('Enter your username or email to change your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Username / Email Address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB2FEFA), Color(0xFF0ED2F7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ElevatedButton(
                    onPressed: () => viewModel.sendResetLink(emailController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Send Email', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Know your Password? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("Sign in",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text('Hiltermann', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const Text('Copyright © 2025 All Rights Reserved', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Privacy Policy', style: TextStyle(fontSize: 10, color: Colors.teal)),
                        Text('  •  ', style: TextStyle(fontSize: 10)),
                        Text('Terms & Conditions', style: TextStyle(fontSize: 10, color: Colors.teal)),
                        Text('  Version 8.24.1545', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// File: viewmodel/forgot_password_viewmodel.dart
class ForgotPasswordViewModel {
  void sendResetLink(String email) {
    if (email.isEmpty) {
      print("Email is empty");
    } else {
      // Simulate API call
      print("Sending password reset link to: $email");
    }
  }
}