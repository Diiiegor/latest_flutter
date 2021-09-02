import 'package:dio/dio.dart';

class ApiProvider {
  static Dio getApi() {
    final dio = new Dio();
    dio.options.baseUrl = 'https://catfact.ninja';
    return dio;
  }
}
