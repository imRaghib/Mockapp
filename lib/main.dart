import 'package:flutter/material.dart';
import 'package:mockapp/utils/routes/routes.dart';
import 'package:mockapp/utils/routes/routes_names.dart';
import 'package:provider/provider.dart';
import 'features/login/viewmodel/login_form_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginFormProvider())],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Elza Round Variable'),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesNames.splash,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
