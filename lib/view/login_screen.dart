import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 83),
                  child: SvgPicture.asset(
                    'lib/assets/icons/logo.svg',
                    semanticsLabel: 'Logo',
                    height: 92,
                    width: 92,
                  ),
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily: 'DM Serif Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 34,
                  ),
                ),
                Text(
                  'Please enter your details',
                  style: TextStyle(
                    fontFamily: 'Elza Round Variable',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    cursorColor: inputColor,
                    style: TextStyle(color: inputColor),
                    decoration: InputDecoration(
                      labelText: 'Enter Username',
                      labelStyle: TextStyle(
                        color: inputColor,
                        fontFamily: 'Elza Round Variable',
                      ),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      border: borderStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    cursorColor: inputColor,
                    style: TextStyle(color: inputColor),
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(
                        color: inputColor,
                        fontFamily: 'Elza Round Variable',
                      ),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      border: borderStyle,
                      suffixIcon: Icon(Icons.remove_red_eye, color: inputColor),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Color(0xFF08B1A2),
                          fontFamily: 'Elza Round Variable',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: selectedOption,
                  onChanged: (value) {
                    selectedOption = value;
                    // Call setState() if this is in a StatefulWidget
                  },
                  items:
                      ['Option 1', 'Option 2', 'Option 3']
                          .map(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(
                                option,
                                style: TextStyle(color: inputColor),
                              ),
                            ),
                          )
                          .toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Option',
                    labelStyle: TextStyle(color: inputColor),
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    border: borderStyle,
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: inputColor),
                  style: TextStyle(color: inputColor),
                  dropdownColor: Colors.white,
                  hint: Text(
                    'Please select',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SvgPicture.asset(
                        'lib/assets/icons/face_id.svg',
                        semanticsLabel: 'Logo',
                        height: 48,
                        width: 70,
                      ),
                    ),
                    Text('Face ID'),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.3919, 0),
                        end: Alignment(1, 0),
                        colors: [
                          Color(0xFF4FC71A), // Green color
                          Color(0xFF07A5CB), // Blue color
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        // Make button background transparent
                        shadowColor: Colors.transparent,
                        // Remove the default shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFF82899B), // Line color
                  thickness: 1, // Line thickness
                  // Space from the right
                ),
                Text('Hiltermann'),
                Text('Copyright @ 2025.All Rights Reserved'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Privacy Policy Terms & Condition',
                      style: TextStyle(
                        color: Color(0xFF08B1A2),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Version 8.24.1545'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
