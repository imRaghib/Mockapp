//Reusable part of UI

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';

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
        width: 340,
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
