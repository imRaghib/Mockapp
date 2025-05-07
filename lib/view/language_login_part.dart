import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mDealer Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final List<String> languages = ['English', 'Dutch', 'German', 'Urdu'];
  final List<String> partners = [
    'External-External Auditor',
    'Internal Partner',
    'viewer of the app',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side — Image and Text
          Expanded(
            flex: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/hiltermann-hiltermann_login_screen_portrait.png',
                  // Replace with your image
                  fit: BoxFit.cover,
                ),
                Container(color: Colors.black.withOpacity(0.4)),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                          endIndent: 200,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Your partner for\nleasing and financing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right Side — Login Form
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/user_icon.png',
                          ), // Optional user icon
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        'Welcome to ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'mDealer',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          children: [],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Enter your email and password to access your account',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 30),

                      // Language Dropdown
                      Text('Language'),
                      SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        items:
                            languages
                                .map(
                                  (lang) => DropdownMenuItem(
                                    value: lang,
                                    child: Text(lang),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Business Partner Dropdown
                      Text('Business Partner'),
                      SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        items:
                            partners
                                .map(
                                  (partner) => DropdownMenuItem(
                                    value: partner,
                                    child: Text(partner),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {},
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.green, Colors.teal],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'CONTINUE',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),

                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hiltermann\n©2025 All Rights Reserved',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Terms & Conditions',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
