import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/login/model/user_model.dart';

class ApiService {
  final String baseUrl = 'http://YOUR_SERVER_IP:3000';

  Future<String> login(User user) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else if (response.statusCode == 401) {
      throw Exception('Invalid username or password');
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
