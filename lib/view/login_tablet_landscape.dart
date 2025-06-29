import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/components/customGradientButton.dart';
import '../../../res/components/face_id_widget.dart';
import '../../../utils/routes/routes_names.dart';
import '../res/components/footer_widget.dart';
import '../view model/login_viewmodel.dart';
import 'mobile view/login_mobile.dart';

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
                      'assets/images/hiltermann_login_screen_landscape.png',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/icons/user_icon.png',
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
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesNames.dashboard,
                              // It removes all routes below the new one (effectively clearing the stack).
                              (route) => false,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaceIdWidget(
                              title: 'Face ID',
                            )
                          ],
                        ),
                        FooterWidget(),
                      ],
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
