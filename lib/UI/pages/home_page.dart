import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/forecast.dart';
import '../../services/api_services.dart';
import '../../services/location_service.dart';
import 'weather_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ApiService _apiService;
  late final LocationService _locationService;
  Forecast? _forecast;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _apiService = GetIt.instance.get<ApiService>();
    _locationService = GetIt.instance.get<LocationService>();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final location = await _locationService.getLocation();
      if (location != null) {
        final lat = location.latitude;
        final lon = location.longitude;
        final forecast = await _apiService.fetchWeatherLocation(lat!, lon!);

        print(lon);
        print(forecast);
        setState(() {
          _forecast = forecast;
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching weather data: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Brizz App'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.white, // White at the bottom
              Colors.lightBlue, // Blue at the top
            ],
          ),
        ),
        child: Center(
          child: _isLoading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Fetching location...'),
            ],
          )
              : _errorMessage != null
              ? Text(_errorMessage!)
              : _forecast != null
              ? WeatherDisplay(forecast: _forecast!)
              : const Text('No weather data available.'),
        ),
      ),

    );
  }
}