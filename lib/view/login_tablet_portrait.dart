import 'package:flutter/material.dart';
import 'package:mockapp/res/components/CustomGradientButton.dart';
import 'package:mockapp/res/components/footer_widget.dart';
import 'package:provider/provider.dart';
import '../../../res/components/face_id_widget.dart';
import '../res/components/heading_widget.dart';
import '../view model/login_viewmodel.dart';
import 'mobile view/login_mobile.dart';

class LoginTabletPortrait extends StatefulWidget {
  const LoginTabletPortrait({super.key});

  @override
  State<LoginTabletPortrait> createState() => _LoginTabletPortraitState();
}

class _LoginTabletPortraitState extends State<LoginTabletPortrait> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildTopImage(size),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 150,
                  vertical: 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        HeadingWidget(text: 'Welcome Back'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Enter your email and password to access your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
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
                        FaceIdWidget(title: 'Face ID'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FooterWidget(),
          ],
        ),
      ),
    );
  }

  Stack buildTopImage(Size size) {
    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/hiltermann_login_screen_portrait.png',
          width: size.width,
          height: 250,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Your partner for',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'leasing and financing',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
