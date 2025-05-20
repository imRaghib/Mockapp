import 'dart:math';
import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet }

DeviceType getDeviceType(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final diagonal =
      sqrt((size.width * size.width) + (size.height * size.height));
  final shortestSide = size.shortestSide;

  if (shortestSide >= 600 && diagonal > 1100) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}

Widget getResponsiveScreen({
  required BuildContext context,
  required Widget mobile,
  required Widget tabletPortrait,
  required Widget tabletLandscape,
}) {
  final orientation = MediaQuery.of(context).orientation;
  final deviceType = getDeviceType(context);

  if (deviceType == DeviceType.tablet) {
    return orientation == Orientation.portrait
        ? tabletPortrait
        : tabletLandscape;
  } else {
    return mobile;
  }
}
