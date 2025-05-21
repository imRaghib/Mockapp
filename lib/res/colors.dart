import 'package:flutter/material.dart';

const Color fontColor = Color.fromRGBO(28, 35, 53, 1);
const Color limeGreenColor = Color.fromRGBO(8, 177, 162, 1);
const List<Color> buttonGradient = [Color(0xFF4FC71A), Color(0xFF07A5CB)];
const List<Color> disableButtonGradient = [
  Color(0x804FC71A), // greenish, 50% opacity
  Color(0x8007A5CB), // bluish, 50% opacity
];
final kGreyColor = Color(0xFF82899B);
final textFieldBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(color: kGreyColor),
);
const Color appGreenColor = Color(0xFF1EAC67);
const backgroundColor = Colors.white;

class AppColors {
  // Global App
  static const Color backgroundColor = Colors.white;

  // Dashboard Screen
  static const Color approvedLimitCircle = Color(0x2427AE60);
  static const Color utilizedLimitCircle = Color(0x29FA7D00);
  static const Color availableLimitCircle = Color(0x2956C9FA);

  static const Color textColor = Color(0xFF697380);
  static const Color cardColor = Colors.white;
}
