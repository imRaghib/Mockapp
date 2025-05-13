import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mockapp/features/login/view/widgets/login_form.dart';
import 'package:mockapp/res/components/loginForm.dart';
import 'package:provider/provider.dart';
import '../../../res/colors.dart';
import '../../../res/components/CustomGradientButton.dart';
import '../../../res/components/login_face_Id.dart';
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
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: SvgPicture.asset(
                    'lib/assets/icons/logo.svg',
                    semanticsLabel: 'Logo',
                    height: 92,
                    width: 92,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: buildWelcomeText(text: 'Welcome Back'),
                ),
                Text(
                  'Please enter your details',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                LoginForm(),
                FaceIdWidget(),
              ],
            ),
            Column(
              children: [
                CustomGradientButton(
                  text: "Login",
                  onPressed: () {
                    Provider.of<LoginFormProvider>(
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
