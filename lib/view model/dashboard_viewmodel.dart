import 'package:flutter/material.dart';
import '../model/dashboard_model.dart';
import '../services/dashboard_service.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardService _service = DashboardService();

  DashboardModel? _dashboard;
  String? _error;
  bool _isLoading = false;

  DashboardModel? get dashboard => _dashboard;

  String? get error => _error;

  bool get isLoading => _isLoading;

  Future<void> loadDashboard(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _dashboard = await _service.fetchDashboard(token);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _dashboard = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
