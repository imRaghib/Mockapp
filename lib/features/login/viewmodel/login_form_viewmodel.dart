import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedSubtenant;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void handleLogin(BuildContext context) {
    if (validateForm()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Form is valid!")));
    }
  }
}
