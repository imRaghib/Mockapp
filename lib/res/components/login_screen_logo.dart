import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SvgPicture.asset(
        'lib/assets/icons/logo.svg',
        semanticsLabel: 'Logo',
        height: 92,
        width: 92,
      ),
    );
  }
}
