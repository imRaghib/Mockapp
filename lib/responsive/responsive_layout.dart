import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tabletPortrait;
  final Widget tabletLandscape;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.tabletPortrait,
    required this.tabletLandscape,
  }) : super(key: key);

  bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = sqrt(
      (size.width * size.width) + (size.height * size.height),
    );
    return diagonal > 1100; // Treat anything over ~7 inches as tablet
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = MediaQuery.of(context).orientation;

        if (isTablet(context)) {
          return orientation == Orientation.portrait
              ? tabletPortrait
              : tabletLandscape;
        } else {
          return mobile;
        }
      },
    );
  }
}
