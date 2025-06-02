import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/dashboard_model.dart';
import '../res/default_urls.dart';
import 'auth_token_viewmodel.dart';

class DashboardViewModel extends ChangeNotifier {
  final AuthTokenViewModel _authTokenViewModel;

  DashboardModel? dashboard;
  bool isLoading = false;
  String? errorMessage;

  DashboardViewModel(this._authTokenViewModel);

  Future<void> fetchDashboard() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    // await _authTokenViewModel.saveToken();
    // await _authTokenViewModel.deleteToken();

    final token = await _authTokenViewModel.getToken();

    if (token == null) {
      errorMessage = 'No token found';
      notifyListeners();
      return;
    }

    final url = Uri.parse('${DefaultURLs.defaultBackendUrl}/api/dashboard');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Pass JWT here
        },
      );
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        dashboard = DashboardModel.fromJson(jsonBody);
      } else {
        errorMessage = 'Failed to fetch dashboard: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
