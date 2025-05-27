import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:mockapp/features/login/view/login_mobile.dart';
import 'package:mockapp/features/login/view/login_screen.dart';
import 'package:mockapp/res/colors.dart';
import 'package:mockapp/res/components/CustomGradientButton.dart';
import 'package:mockapp/res/components/login_screen_logo.dart';
import 'package:mockapp/res/components/login_secondary_text.dart';

class LoginForgetScreen extends StatelessWidget {
  const LoginForgetScreen({super.key});

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
                BuildBoldText(text: 'Forgot Password'),
                SecondaryText(),
                SizedBox(height: 40),
                TextFormField(
                  //   controller: null,
                  // have to implement it later
                  cursorColor: kGreyColor,
                  style: TextStyle(color: kGreyColor),
                  decoration: InputDecoration(
                    labelText: 'Enter Username',
                    labelStyle: TextStyle(color: kGreyColor),
                    enabledBorder: textFieldBorderStyle,
                    focusedBorder: textFieldBorderStyle,
                    border: textFieldBorderStyle,
                  ),
                  // validator:
                  //     (value) =>
                  //         value == null || value.isEmpty
                  //             ? 'Invalid username'
                  //             : null,
                ),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: 'Know your password?'),
                      TextSpan(
                        text: ' Sign in',
                        style: TextStyle(color: limeGreenColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomGradientButton(
                  title: "Send",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return _GifSuccessBottomSheet();
                      },
                    );
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

class _GifSuccessBottomSheet extends StatefulWidget {
  @override
  State<_GifSuccessBottomSheet> createState() => _GifSuccessBottomSheetState();
}

class _GifSuccessBottomSheetState extends State<_GifSuccessBottomSheet>
    with TickerProviderStateMixin {
  late GifController controller;

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);
    // Play the GIF only once when the widget is built// Starts playing the GIF once
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Gif(
                duration: const Duration(seconds: 2),
                autostart: Autostart.loop,
                controller: controller,
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/videos/loading.gif'),
              ),
            ),
            Text(
              'Success!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Request has been submitted successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            CustomGradientButton(
              title: 'Go to Login Page ',
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginMobile()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
