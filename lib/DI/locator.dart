import 'dart:convert';

import 'package:briz/services/location_service.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../models/app_config.dart';
import '../services/api_services.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await _loadConfig();
  registerApiService();
  registerLocationService();
}

Future<void> _loadConfig() async {
  String configContent = await rootBundle.loadString("assets/config/main.json");
  Map<String, dynamic> configData = jsonDecode(configContent);
  getIt.registerSingleton<AppConfig>(
    AppConfig(
      WEATHER_URL: configData["WEATHER_URL"],
      API_KEY: configData['API_KEY'],
    ),
  );
}
void registerApiService(){
  getIt.registerSingleton<ApiService>(
    ApiService(),
  );
}

void registerLocationService(){
  getIt.registerSingleton<LocationService>(
    LocationService(),
  );
}

