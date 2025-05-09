import 'package:mockapp/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
}
