//Handles logic, state

import 'package:flutter/material.dart';
import 'package:mockapp/features/login/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginFormModel _form = LoginFormModel();

  String get username => _form.username;

  String get password => _form.password;

  String? get subtenant => _form.subtenant;

  bool get isValid => _form.isValidForm;

  void setUsername(String value) {
    _form.username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _form.password = value;
    notifyListeners();
  }

  void setSubtenant(String? value) {
    _form.subtenant = value;
    notifyListeners();
  }
}
