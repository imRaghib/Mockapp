// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// class LoginFormProvider extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   String? selectedSubtenant;
//
//   bool _loading = false;
//
//   bool get loading => _loading;
//
//   String? _errorMessage;
//
//   String? get errorMessage => _errorMessage;
//
//   String? _token;
//
//   String? get token => _token;
//
//   Future<bool> login(BuildContext context) async {
//     if (!formKey.currentState!.validate()) {
//       return false;
//     }
//
//     _loading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     final loginForm = Provider.of<LoginFormProvider>(context);
//
//     try {
//       final url = Uri.parse('http://localhost:3000/login');
//
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': loginForm.usernameController.text.trim(),
//           'password': loginForm.passwordController.text.trim(),
//           'subtenant': selectedSubtenant,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _token = data['token'];
//         _loading = false;
//         notifyListeners();
//         return true;
//       } else if (response.statusCode == 401) {
//         _errorMessage = 'Invalid username or password';
//         print(_errorMessage);
//       } else {
//         _errorMessage = 'Login failed: ${response.statusCode}';
//         print(_errorMessage);
//       }
//     } catch (e) {
//       _errorMessage = 'Error: $e';
//       print(_errorMessage);
//     }
//
//     _loading = false;
//     notifyListeners();
//     return false;
//   }
//
//   @override
//   void dispose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }
