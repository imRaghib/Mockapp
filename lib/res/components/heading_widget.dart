import 'package:flutter/material.dart';
import '../colors.dart';

class HeadingWidget extends StatelessWidget {
  final String text;

  const HeadingWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
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
}
