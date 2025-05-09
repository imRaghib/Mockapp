import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mockapp/features/login/view/widgets/constants.dart';
import 'package:mockapp/features/login/view/widgets/login_form.dart';

const subtenantList = ['', ''];

class LoginTabletLandscape extends StatefulWidget {
  const LoginTabletLandscape({super.key});

  @override
  State<LoginTabletLandscape> createState() => _LoginTabletLandscapeState();
}

class _LoginTabletLandscapeState extends State<LoginTabletLandscape> {
  final List<String> languages = ['English', 'Dutch', 'German', 'Urdu'];
  final List<String> partners = [
    'External-External Auditor',
    'Internal Partner',
    'viewer of the app',
  ];

  @override
  Widget build(BuildContext context) {
    final inputColor = Color(0xFF82899B);
    final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: inputColor),
    );

    String? selectedOption;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'lib/assets/images/hiltermann_login_screen_landscape.png',
                    // Replace with your image
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.4)),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 5, // Thickness of the divider
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white, // Divider color
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // Rounded corners
                            ),
                          ),

                          Text(
                            'Your partner for\nleasing and financing',
                            style: TextStyle(
                              fontFamily: 'DM Serif Display',
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'lib/assets/icons/user_icon.png',
                            ), // Optional user icon
                          ),
                        ),
                        SizedBox(height: 60),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 28),
                            children: [
                              TextSpan(
                                text: 'Welcome to ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'mDealer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enter your email and password to access your account',
                          style: TextStyle(color: Colors.grey[700]),
                        ),

                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: TextField(
                                cursorColor: inputColor,
                                style: TextStyle(color: inputColor),
                                decoration: InputDecoration(
                                  labelText: 'Enter Username',
                                  labelStyle: TextStyle(color: inputColor),
                                  enabledBorder: borderStyle,
                                  focusedBorder: borderStyle,
                                  border: borderStyle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: TextField(
                                cursorColor: inputColor,
                                style: TextStyle(color: inputColor),
                                decoration: InputDecoration(
                                  labelText: 'Enter Password',
                                  labelStyle: TextStyle(color: inputColor),
                                  enabledBorder: borderStyle,
                                  focusedBorder: borderStyle,
                                  border: borderStyle,
                                  suffixIcon: Icon(
                                    Icons.remove_red_eye,
                                    color: inputColor,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Text(
                                    'Forgot Password?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: limeGreenColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: DropdownButtonFormField<String>(
                                value: selectedOption,
                                onChanged: (value) {
                                  selectedOption = value;
                                  // Call setState() if this is in a StatefulWidget
                                },
                                items:
                                    subtenantList
                                        .map(
                                          (option) => DropdownMenuItem(
                                            value: option,
                                            child: Text(
                                              option,
                                              style: TextStyle(
                                                color: inputColor,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                decoration: InputDecoration(
                                  labelText: 'Subtenant',
                                  labelStyle: TextStyle(color: inputColor),
                                  enabledBorder: borderStyle,
                                  focusedBorder: borderStyle,
                                  border: borderStyle,
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: inputColor,
                                ),
                                style: TextStyle(color: inputColor),
                                dropdownColor: Colors.white,
                                hint: Text(
                                  'Please select',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            CustomGradientButton(
                              text: 'Login',
                              onPressed: () {},
                            ),
                            buildFaceId(),
                          ],
                        ),

                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hiltermann\n©2025 All Rights Reserved',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
