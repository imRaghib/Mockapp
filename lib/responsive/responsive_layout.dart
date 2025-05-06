import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile; // For iPhones
  final Widget tabletPortrait; // For iPad Portrait
  final Widget tabletLandscape; // For iPad Landscape

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tabletLandscape,
    required this.tabletPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // iPhone and smaller devices
          return mobile;
        } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 900) {
          // iPad in Portrait
          return tabletPortrait;
        } else {
          // iPad in Landscape or larger
          return tabletLandscape;
        }
      },
    );
  }
}
