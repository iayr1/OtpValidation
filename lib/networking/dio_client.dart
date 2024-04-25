import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  static void setupInterceptors() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
