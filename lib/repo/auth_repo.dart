import 'package:dio/dio.dart';
import '../models/auth_model.dart';
import '../networking/api_endpoints.dart';

class AuthenticationRepository {
  final Dio _dio;

  AuthenticationRepository({required Dio dio}) : _dio = dio;

  Future<void> login(AuthenticationModel authModel) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.sendOtp,
        data: authModel.toJson(),
      );
      print('Login response: ${response.data}');
    } catch (error) {
      print('Error during login: $error');
    }
  }
}
