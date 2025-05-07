//Entry point: uses ResponsiveLayout

import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/login_mobile.dart';
import 'package:mockapp/features/login/view/login_tablet_landscape.dart';
import 'package:mockapp/features/login/view/login_tablet_portrait.dart';
import '../../../responsive/responsive_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: LoginMobile(),
      tabletPortrait: LoginTabletPortrait(), // change this to different screens
      tabletLandscape: LoginTabletLandscape(),
    );
  }
}
