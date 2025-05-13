import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/login_forget_screen.dart';
import 'package:provider/provider.dart';
import '../../features/login/viewmodel/login_form_viewmodel.dart';
import '../colors.dart';

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
            cursorColor: textFieldColor,
            style: TextStyle(color: textFieldColor),
            decoration: InputDecoration(
              labelText: 'Enter Username',
              labelStyle: TextStyle(color: textFieldColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
            ),
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'Invalid username' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: loginForm.passwordController,
            obscureText: true,
            cursorColor: textFieldColor,
            style: TextStyle(color: textFieldColor),
            decoration: InputDecoration(
              labelText: 'Enter Password',
              labelStyle: TextStyle(color: textFieldColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
              suffixIcon: const Icon(Icons.visibility),
            ),
            validator:
                (value) =>
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
            items:
                ['HML', 'ABC', 'XYZ']
                    .map(
                      (subtenant) => DropdownMenuItem<String>(
                        value: subtenant,
                        child: Text(subtenant),
                      ),
                    )
                    .toList(),
            decoration: InputDecoration(
              labelText: 'Subtenant',
              labelStyle: TextStyle(color: textFieldColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
            ),
            icon: Icon(Icons.arrow_drop_down, color: textFieldColor),
            style: TextStyle(color: textFieldColor),
            dropdownColor: Colors.white,
            validator:
                (value) => value == null ? 'Please select a subtenant' : null,
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
