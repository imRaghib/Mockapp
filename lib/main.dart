import 'package:flutter/material.dart';
import 'package:mockapp/features/finance%20request/finance_request_mobile.dart';
import 'package:provider/provider.dart';
import 'features/login/viewmodel/login_form_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginFormProvider())],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Elza Round Variable'),
        debugShowCheckedModeBanner: false,
        home: FinanceRequestMobile(), // Add your screen here to test.
      ),
    );
  }
}
