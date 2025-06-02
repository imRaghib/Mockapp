import 'package:flutter/material.dart';
import 'package:mockapp/res/font_family.dart';
import 'package:mockapp/utils/routes/routes.dart';
import 'package:mockapp/utils/routes/routes_names.dart';
import 'package:mockapp/view%20model/auth_token_viewmodel.dart';
import 'package:mockapp/view%20model/dashboard_viewmodel.dart';
import 'package:mockapp/view/title_bar.dart';
import 'package:provider/provider.dart';
import 'view model/login_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthTokenViewModel()),
        ChangeNotifierProxyProvider<AuthTokenViewModel, DashboardViewModel>(
          create: (context) => DashboardViewModel(
              Provider.of<AuthTokenViewModel>(context, listen: false)),
          update: (context, authTokenModel, _) =>
              DashboardViewModel(authTokenModel),
        ),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: AppFonts.elza),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesNames.login,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
