import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/login_mobile.dart';
import 'package:mockapp/features/login/view/login_tablet_landscape.dart';
import 'package:mockapp/features/login/view/login_tablet_portrait.dart';
import 'package:mockapp/utils/responsive_helper.dart';
import 'package:mockapp/view/dashboard_mobile.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../view/dashboard_tablet_landscape.dart';
import '../../view/splash_screen.dart';
import 'routes_names.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(
          builder: (context) {
            final deviceType = getDeviceType(context);
            return deviceType == DeviceType.tablet
                ? const SplashVideoScreen()
                : const OnboardingScreen();
          },
        );
      case RoutesNames.login:
        return MaterialPageRoute(
          builder: (context) => getResponsiveScreen(
            context: context,
            mobile: LoginMobile(),
            tabletPortrait: LoginTabletPortrait(),
            tabletLandscape: LoginTabletLandscape(),
          ),
        );

      case RoutesNames.dashboard:
        return MaterialPageRoute(
          builder: (context) => getResponsiveScreen(
            context: context,
            mobile: DashboardMobile(),
            tabletPortrait: DashboardScreen(),
            tabletLandscape: DashboardScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
