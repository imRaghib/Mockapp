import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/widgets/login_form.dart';
import 'package:mockapp/res/components/loginForm.dart';
import 'package:mockapp/res/components/login_screen_logo.dart';
import 'package:mockapp/res/components/login_secondary_text.dart';
import 'package:mockapp/utils/routes/routes_names.dart';
import 'package:provider/provider.dart';
import '../../../res/colors.dart';
import '../../../res/components/CustomGradientButton.dart';
import '../../../res/components/login_face_Id.dart';

// import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/login_form_viewmodel.dart';

class LoginMobile extends StatelessWidget {
  const LoginMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 84,
          bottom: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                LogoWidget(height: null),
                BuildBoldText(text: 'Welcome Back'),
                SecondaryText(),
                SizedBox(height: 20),
                LoginForm(),
                FaceIdWidget(),
              ],
            ),
            Column(
              children: [
                CustomGradientButton(
                  title: "Login",
                  onPressed: () {
                    // Provider.of<LoginFormProvider>(
                    //   context,
                    //   listen: false,
                    // ).login(context);
                    final res = Provider.of<LoginFormProvider>(
                      context,
                      listen: false,
                    ).handleLogin(context);
                  },
                ),
                buildFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Column buildFooter() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Divider(
          color: Color.fromRGBO(244, 245, 246, 1), // Line color
          thickness: 1, // Line thickness
          // Space from the right
        ),
      ),
      Text(
        'Hiltermann',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      Text('Copyright @ 2025.All Rights Reserved'),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Privacy Policy Terms & Condition',
              style: TextStyle(
                color: limeGreenColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Version 8.24.1545'),
          ],
        ),
      ),
    ],
  );
}

class BuildBoldText extends StatelessWidget {
  final String text;

  const BuildBoldText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: buildWelcomeText(text: text),
    );
  }
}
