import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors.dart';

class FaceIdWidget extends StatelessWidget {
  const FaceIdWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}
