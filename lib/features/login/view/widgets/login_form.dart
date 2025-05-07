//Reusable part of UI

import 'package:flutter/material.dart';
import 'constants.dart';

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
