import 'package:flutter/material.dart';
import '../../models/forecast.dart';

class WeatherInfoCard extends StatelessWidget {
  final String humidity;
  final String feelsLikeTemp;
  final String windSpeed;

  const WeatherInfoCard({
    super.key,
    required this.humidity,
    required this.feelsLikeTemp,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50], // Background color for the card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Icon(Icons.water_drop, color: Colors.blue),
                const Text('Humidity'),
                Text('$humidity%'),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.thermostat, color: Colors.red),
                const Text('Feels Like'),
                Text('$feelsLikeTemp°C'),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.air, color: Colors.green),
                const Text('Wind'),
                Text('${windSpeed}km/h'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
