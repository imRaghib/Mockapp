//Optional: User data

class LoginFormModel {
  String username = '';
  String password = '';
  String? subtenant;

  bool get isValidUsername => username.isNotEmpty;

  // && RegExp(r'^[a-zA-Z0-9_]+\$').hasMatch(username);

  bool get isValidPassword => password.isNotEmpty;

  bool get isValidForm =>
      isValidUsername && isValidPassword && subtenant != null;
}
