//Tablet portrait layout

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockapp/features/login/view/widgets/login_form.dart';

class LoginTabletPortrait extends StatefulWidget {
  const LoginTabletPortrait({super.key});

  @override
  State<LoginTabletPortrait> createState() => _LoginTabletPortraitState();
}

class _LoginTabletPortraitState extends State<LoginTabletPortrait> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top image with overlay text
            Stack(
              children: [
                Image.asset(
                  'lib/assets/images/hiltermann_login_screen_portrait.png',

                  width: size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Your partner for',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'leasing and financing',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Welcome message
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your email and password to access your account',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Email field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username / Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
            ),

            // Forgot Password
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
            ),

            // Subtenant
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Subtenant',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Login Button with Gradient
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color(
                      0xFF00FF00,
                    ), // Temporary solid color
                  ).copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      return null; // Let ShaderMask handle it
                    }),
                  ),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFB7E5D6), Color(0xFF94D0F4)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Face ID
            Column(
              children: const [
                Icon(
                  Icons.face_retouching_natural,
                  size: 40,
                  color: Colors.teal,
                ),
                SizedBox(height: 8),
                Text('Face ID', style: TextStyle(color: Colors.teal)),
              ],
            ),

            const SizedBox(height: 40),

            // Footer
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Hiltermann\nCopyright © 2025 All Rights Reserved',
                    style: TextStyle(fontSize: 12),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Privacy Policy   •   Terms & Conditions',
                        style: TextStyle(fontSize: 12, color: Colors.teal),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Version 2.84.1545',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Padding(
  //       padding: const EdgeInsets.only(bottom: 30),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Image.asset(
  //             'lib/assets/images/hiltermann_login_screen_portrait.png',
  //           ),
  //           buildFooter(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
