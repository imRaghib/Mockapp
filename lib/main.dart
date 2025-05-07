import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/login_screen.dart';

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
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Elza Round Variable'),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Add your screen here to test.
    );
  }
}
