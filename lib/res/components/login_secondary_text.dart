import 'package:flutter/material.dart';

class SecondaryText extends StatelessWidget {
  const SecondaryText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Please enter your details',
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    );
  }
}
