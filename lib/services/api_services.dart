import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/app_config.dart';
import '../models/forecast.dart';

class ApiService {
  final Dio dio = Dio();

  AppConfig? appConfig;
  String? baseUrl;
  String? apiKey;

  ApiService() {
    appConfig = GetIt.instance.get<AppConfig>();
    baseUrl = appConfig!.WEATHER_URL;
    apiKey = appConfig!.API_KEY;

    dio.options.headers = {'accept': 'application/json'};
  }

  Future<Forecast?> fetchWeatherLocation(double lat, double lon) async {
    try {
      final response = await dio.get('$baseUrl', queryParameters: {
        'key': '$apiKey',
        'q': '$lat,$lon',
        'days': 14,
      });
      return Forecast.fromJson(response.data);
      // return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
