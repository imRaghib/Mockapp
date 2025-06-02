import 'package:flutter/material.dart';

class SubheadingWidget extends StatelessWidget {
  final String text;

  const SubheadingWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    );
  }
}
