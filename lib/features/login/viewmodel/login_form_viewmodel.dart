import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockapp/res/default_urls.dart';
import 'package:provider/provider.dart';
import '../../../data/network/secure_storage_service.dart';
import '../../../utils/routes/routes_names.dart';
import '../../../view model/dashboard_viewmodel.dart';

class LoginFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedSubtenant;

  final SecureStorageService _secureStorageService = SecureStorageService();
  String? errorMessage;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> handleLogin(BuildContext context) async {
    final loginForm = Provider.of<LoginFormProvider>(context, listen: false);

    if (validateForm()) {
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text("Form is valid!")));

      final url = Uri.parse('${DefaultURLs.defaultBackendUrl}/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': loginForm.usernameController.text.trim(),
          'password': loginForm.passwordController.text.trim(),
          'subtenant': selectedSubtenant,
        }),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final token = body['token'];

        await _secureStorageService.saveToken(token);

        // ⬇️ Call DashboardProvider's loadDashboard() with the token
        final dashboardProvider =
            Provider.of<DashboardProvider>(context, listen: false);
        try {
          await dashboardProvider.loadDashboard(token);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.dashboard,
            (route) => false,
          );
        } catch (e) {
          errorMessage = 'Failed to load dashboard';
          notifyListeners();
        }
      } else {
        errorMessage = json.decode(response.body)['message'] ?? 'Login failed';
        notifyListeners();
      }
    }
  }
}
