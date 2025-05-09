//Reusable part of UI

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const UsernameField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Enter Username',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !RegExp(r'^[a-zA-Z0-9_]+\$').hasMatch(value)) {
          return 'Invalid username';
        }
        return null;
      },
    );
  }
}

// WIDGET: widgets/password_field.dart

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const PasswordField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Enter Password',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.visibility),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password required';
        }
        return null;
      },
    );
  }
}

// WIDGET: widgets/subtenant_dropdown.dart

class SubtenantDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const SubtenantDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items:
          items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
      decoration: const InputDecoration(
        labelText: 'Subtenant',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value == null ? 'Please select a subtenant' : null,
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomGradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF4FC71A), // Start: Green
              Color(0xFF07A5CB), // End: Teal Blue
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Text buildWelcomeText({required String text}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'DM Serif Display',
      fontWeight: FontWeight.w400,
      color: fontColor,
      fontSize: 34,
    ),
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

Column buildFooter() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Divider(
          color: Color.fromRGBO(244, 245, 246, 1), // Line color
          thickness: 1, // Line thickness
          // Space from the right
        ),
      ),
      Text(
        'Hiltermann',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Text('Copyright @ 2025.All Rights Reserved'),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Privacy Policy Terms & Condition',
              style: TextStyle(
                color: limeGreenColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Version 8.24.1545'),
          ],
        ),
      ),
    ],
  );
}
