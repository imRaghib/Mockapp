import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mockapp/res/svg_icons.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  final double width;

  const LogoWidget({
    super.key,
    this.height = 92.0,
    this.width = 92.0,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppIcons.hiltermanIcon,
      semanticsLabel: 'Logo',
      height: height,
      width: width,
    );
  }
}
