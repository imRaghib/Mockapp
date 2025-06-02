import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockapp/res/svg_icons.dart';
import '../colors.dart';

class FaceIdWidget extends StatelessWidget {
  final double height;
  final double weight;
  final String title;

  const FaceIdWidget({
    super.key,
    this.height = 48,
    this.weight = 70,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SvgPicture.asset(
            AppIcons.faceIdIcon,
            semanticsLabel: 'Logo',
            height: height,
            width: weight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
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
