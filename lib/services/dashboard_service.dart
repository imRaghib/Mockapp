import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/dashboard_model.dart';

class DashboardService {
  final String baseUrl = 'http://localhost:3000'; // or your deployed URL

  Future<DashboardModel> fetchDashboard(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
      headers: {'Authorization': 'Bearer $token'}, // Send JWT
    );

    if (response.statusCode == 200) {
      return DashboardModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dashboard');
    }
  }
}
