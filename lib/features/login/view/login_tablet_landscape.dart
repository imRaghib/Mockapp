import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/components/customGradientButton.dart';
import '../../../res/components/loginForm.dart';
import '../../../res/components/login_face_Id.dart';
import '../../../res/components/login_tab_footer.dart';
import '../viewmodel/login_form_viewmodel.dart';

class LoginTabletLandscape extends StatefulWidget {
  const LoginTabletLandscape({super.key});

  @override
  State<LoginTabletLandscape> createState() => _LoginTabletLandscapeState();
}

class _LoginTabletLandscapeState extends State<LoginTabletLandscape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'lib/assets/images/hiltermann_login_screen_landscape.png',
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
                            Container(
                              width: 150,
                              height: 5, // Thickness of the divider
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.white, // Divider color
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // Rounded corners
                              ),
                            ),
                            Text(
                              'Your partner for\nleasing and financing',
                              style: TextStyle(
                                fontFamily: 'DM Serif Display',
                                color: Colors.white,
                                fontSize: 48,
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
                                'lib/assets/icons/user_icon.png',
                              ), // Optional user icon
                            ),
                          ),
                          SizedBox(height: 60),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 28),
                              children: [
                                TextSpan(
                                  text: 'Welcome to ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'mDealer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter your email and password to access your account',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 24),
                          LoginForm(),
                          const SizedBox(height: 24),
                          CustomGradientButton(
                            title: "Login",
                            onPressed: () {
                              Provider.of<LoginFormProvider>(
                                context,
                                listen: false,
                              ).handleLogin(context);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [FaceIdWidget()],
                          ),
                          Footer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
