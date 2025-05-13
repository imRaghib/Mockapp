import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart'; //importing the title_bar.dart file which is already made.


void main() {
  runApp(
    ChangeNotifierProvider(
      //telling Flutter to create a NotificationViewModel and share it with widgets in the widget tree
      //automatically changes the Ui whenever there are changes in the tree.
      create: (_) => NotificationViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
//super.key->concept of inheritance.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terms & Conditions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TermsAndConditionsScreen(),
    );
  }
}

//main screen that users will see.
class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  //allows the widget to rebuild and reflect any
  // changes made to its state, like updating the UI when a user interacts with it
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}
         //class                      //controls                //screen
class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _isAgreed = false; //_isAgreed is a variable that stores whether the user has agreed to the terms
  //be default it is set false so that the user checks the box to move ahead.

  void _onAgreeChanged(bool? value) {
    setState(() {
      _isAgreed = value ?? false;
    });
  }

  void _onNextPressed() {
    if (_isAgreed) {
      Navigator.push( //used to move to the next screen.
        context,
        MaterialPageRoute(builder: (context) => const NextScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms before continuing.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(), //
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.teal),
              label: const Text(
                'Back',
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const _Section(
              title: 'Introduction',
              body:
              'Welcome to our application. This document outlines important information regarding your use of the platform, services, and content. Please review all sections carefully before proceeding further.',
            ),
            const _Section(
              title: 'Eligibility',
              body:
              'You must be at least 18 years old to use this app. You are solely responsible for maintaining the confidentiality of your login credentials.',
            ),
            const _Section(
              title: 'Code of Conduct',
              body:
              'Do not abuse, harass, threaten, or intimidate other users. This won’t be allowed and you will be removed.',
            ),
            const _Section(
              title: 'Modifications and Termination',
              body:
              'We reserve the right to modify or terminate the service for any reason, without notice.\nWe are not responsible for any data loss or service interruption.',
            ),
            const _Section(
              title: 'Contact Us',
              body:
              'If you have any questions, feel free to contact us at support@example.com.',
            ),
            const SizedBox(height: 24),
            //Checkbox that lets the user agree to the terms.
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('I agree to the Terms and Conditions', style: TextStyle(fontSize: 16)),
              value: _isAgreed,
              onChanged: _onAgreeChanged,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onNextPressed, //If the checkbox is ticked, it navigates to NextScreen.
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;

  const _Section({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(body, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

// Dummy NextScreen just to test the flow
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(),
      body: const Center(child: Text('Receipts will be downloaded now.')),
    );
  }
}
