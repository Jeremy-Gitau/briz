import 'package:briz/UI/pages/weather_info_card.dart';
import 'package:flutter/material.dart';

import '../../models/forecast.dart';
import 'fourteen_day_forecast.dart';
import 'hourly_forecast.dart';

class WeatherDisplay extends StatelessWidget {
  final Forecast forecast;

  const WeatherDisplay({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.network(
              'https:${forecast.currentDay.condition.icon}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${forecast.currentDay.tempC}°C',
            style: const TextStyle(fontSize: 45),
          ),
          const SizedBox(height: 10),
          Text(
            forecast.currentDay.condition.text,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.black),
              const SizedBox(width: 4),
              Text(
                forecast.weatherLocation.name,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 2),
          WeatherInfoCard(
            humidity: forecast.humidity,
            feelsLikeTemp: forecast.feelsLike,
            windSpeed: forecast.windSpeed,
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                "Today",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 200, // Specify a fixed height for the hourly forecast
            child: HourlyForecast(
              hourlyForecasts: forecast.forecastDays.first.hours,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                "14 Day Forecast",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          FourteenDayForecastCard(forecastDays: forecast.forecastDays),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
