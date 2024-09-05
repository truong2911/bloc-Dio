import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5/';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<Map<String, dynamic>> getWeather(String city) async {
    final response = await _dio.get(
      'weather',
      queryParameters: {
        'q': city,
        'appid': 'f99f50e87f4c94cf8a2abe21813f245e',
      },
    );
    return response.data;
  }
}
