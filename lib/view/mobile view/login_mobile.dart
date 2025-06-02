import 'package:flutter/material.dart';
import 'package:mockapp/res/components/logo_widget.dart';
import 'package:mockapp/res/components/subheading_widget.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../res/components/CustomGradientButton.dart';
import '../../res/components/footer_widget.dart';
import '../../res/components/heading_widget.dart';
import '../../res/components/face_id_widget.dart';
import '../../res/default_padding.dart';
import '../../view model/login_viewmodel.dart';
import 'login_forget_mobile.dart';

class LoginMobile extends StatelessWidget {
  const LoginMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Spacer(),
                  LogoWidget(),
                  SizedBox(height: AppPadding.md),
                  HeadingWidget(text: 'Welcome Back'),
                  SubheadingWidget(text: 'Please enter your details'),
                  SizedBox(height: AppPadding.lg),
                  LoginForm(),
                  FaceIdWidget(title: 'Face ID'),
                  Spacer(),
                  CustomGradientButton(
                    title: "Login",
                    onPressed: () {
                      // Provider.of<LoginFormProvider>(
                      //   context,
                      //   listen: false,
                      // ).login(context);
                      // final res = Provider.of<LoginFormProvider>(
                      //   context,
                      //   listen: false,
                      // ).handleLogin(context);
                    },
                  ),
                  FooterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: loginForm.usernameController,
            cursorColor: kGreyColor,
            style: TextStyle(color: kGreyColor),
            decoration: InputDecoration(
              labelText: 'Enter Username',
              labelStyle: TextStyle(color: kGreyColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Invalid username' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: loginForm.passwordController,
            obscureText: true,
            cursorColor: kGreyColor,
            style: TextStyle(color: kGreyColor),
            decoration: InputDecoration(
              labelText: 'Enter Password',
              labelStyle: TextStyle(color: kGreyColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
              suffixIcon: const Icon(Icons.visibility),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Password required' : null,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginForgetScreen()),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: limeGreenColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: loginForm.selectedSubtenant,
            items: ['HML', 'ABC', 'XYZ']
                .map(
                  (subtenant) => DropdownMenuItem<String>(
                    value: subtenant,
                    child: Text(subtenant),
                  ),
                )
                .toList(),
            decoration: InputDecoration(
              labelText: 'Subtenant',
              hintText: 'Please Select',
              labelStyle: TextStyle(color: kGreyColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
            ),
            icon: Icon(Icons.arrow_drop_down, color: kGreyColor),
            style: TextStyle(color: kGreyColor),
            dropdownColor: Colors.white,
            validator: (value) =>
                value == null ? 'Please select a subtenant' : null,
            onChanged: (value) {
              loginForm.selectedSubtenant = value;
              loginForm.notifyListeners();
            },
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final LoginFormProvider loginForm;

  const TextFieldWidget({super.key, required this.loginForm});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginForm.usernameController,
      cursorColor: kGreyColor,
      style: TextStyle(color: kGreyColor),
      decoration: InputDecoration(
        labelText: 'Enter Username',
        labelStyle: TextStyle(color: kGreyColor),
        enabledBorder: textFieldBorderStyle,
        focusedBorder: textFieldBorderStyle,
        border: textFieldBorderStyle,
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Invalid username' : null,
    );
  }
}
