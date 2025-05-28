import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/dashboard_model.dart';
import '../res/default_urls.dart';
import '../view/dashboard_mobile.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardModel? dashboard;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchDashboard() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('${DefaultURLs.defaultBackendUrl}/api/dashboard');

    try {
      final response = await http.get(url);
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
