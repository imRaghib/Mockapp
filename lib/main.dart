import 'package:flutter/material.dart';
import 'package:mockapp/responsive/responsive_login_screen.dart';

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
      home: const ResponsiveLoginScreen(), // Add your screen here to test.
    );
  }
}
