import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/login_screen.dart';
import 'package:mockapp/features/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Elza Round Variable'),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Add your screen here to test.
    );
  }
}
