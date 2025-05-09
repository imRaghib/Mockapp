//Reusable part of UI

import 'package:flutter/material.dart';
import '../../../../res/colors.dart';

class Utils {
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

Text buildWelcomeText({required String text}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'DM Serif Display',
      fontWeight: FontWeight.w400,
      color: fontColor,
      fontSize: 34,
    ),
  );
}
