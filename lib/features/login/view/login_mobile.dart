//Mobile layout

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mockapp/features/login/view/widgets/constants.dart';
import 'package:mockapp/features/login/view/widgets/login_form.dart';

const subtenantList = ['', ''];

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
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
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 84,
          bottom: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: SvgPicture.asset(
                    'lib/assets/icons/logo.svg',
                    semanticsLabel: 'Logo',
                    height: 92,
                    width: 92,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontFamily: 'DM Serif Display',
                      fontWeight: FontWeight.w400,
                      color: fontColor,
                      fontSize: 34,
                    ),
                  ),
                ),
                Text(
                  'Please enter your details',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
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
                      suffixIcon: Icon(Icons.remove_red_eye, color: inputColor),
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
                                  style: TextStyle(color: inputColor),
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
                    icon: Icon(Icons.arrow_drop_down, color: inputColor),
                    style: TextStyle(color: inputColor),
                    dropdownColor: Colors.white,
                    hint: Text(
                      'Please select',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                buildFaceId(),
              ],
            ),
            Column(
              children: [
                buildButton(context: context, buttonName: 'Login'),
                buildFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildFaceId() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SvgPicture.asset(
            'lib/assets/icons/face_id.svg',
            semanticsLabel: 'Logo',
            height: 48,
            width: 70,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Face ID',
            style: TextStyle(
              color: limeGreenColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox buildButton({
    required BuildContext context,
    required String buttonName,
  }) {
    return SizedBox(
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
            buttonName,
            style: TextStyle(
              color: Colors.white, // Text color
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
