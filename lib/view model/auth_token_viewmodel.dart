import 'package:flutter/material.dart';
import 'package:mockapp/model/auth_token_model.dart';

class AuthTokenViewModel extends ChangeNotifier {
  final AuthTokenModel _storageService = AuthTokenModel();
  static const String tempToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InJhZ2hpYiIsImlhdCI6MTc0ODUwMjMwNywiZXhwIjoxNzQ4NTM4MzA3fQ.KeKsuoe6QFOR6aNfTsKa0A4EIhtX64df6l-IvR1eSbc";

  Future<void> saveToken({String token = tempToken}) async {
    await _storageService.saveToken(token);
    // notifyListeners(); // Only if needed for UI changes
  }

  Future<String?> getToken() async {
    return await _storageService.getToken();
  }

  Future<void> deleteToken() async {
    await _storageService.deleteToken();
    // notifyListeners(); // Only if needed for UI changes
  }
}
