import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart'; // Importing the title bar


void main() {
  runApp(
    MultiProvider( //to pass several dependencies down the widget tree.
      providers: [
      //Creates and provides an instance of NotificationViewModel to the entire widget tree
        ChangeNotifierProvider(create: (_) => NotificationViewModel()), //This is the function that actually creates the instance.

      ],
      child: const MyApp(),
      //The rest of my app is nested inside and has access to the NotificationViewModel.
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy Policy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PrivacyPolicyScreen(),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Widget _buildSection(String heading, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const sampleContent =
        "At Hiltermann, we value your privacy and are committed to protecting your personal information. "
        "This policy outlines how we collect, use, and safeguard your data when you use our services. "
        "Our goal is to ensure full transparency and build trust with our users.";

    return Scaffold(
      appBar: const TitleBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Privacy Policy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildSection('1. Introduction', sampleContent),// using samplecontent To avoid repeating the same long string multiple times.
                  _buildSection('2. Information We Collect', sampleContent),
                  _buildSection('3. How We Use Information', sampleContent),
                  _buildSection('4. Data Security', sampleContent),
                  _buildSection('5. Your Rights', sampleContent),
                  _buildSection('6. Contact Us', sampleContent),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
