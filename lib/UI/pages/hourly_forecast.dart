import 'package:flutter/material.dart';

import '../../models/forecast.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final double temperature;
  final String iconUrl;
  final bool isCurrent;

  const HourlyForecastCard({
    required this.time,
    required this.temperature,
    required this.iconUrl,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrent ? Colors.orange[50] : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time.substring(11, 16), // Extract only the time part (HH:mm)
              style: const TextStyle(fontSize: 16), // Reduce font size for time
            ),
            const SizedBox(height: 8),
            Image.network(
              'https:$iconUrl',
              width: 64, // Reduce image size
              height: 64, // Reduce image size
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              '${temperature.toStringAsFixed(1)}°C',
              // Limit temperature to 1 decimal place
              style: const TextStyle(
                  fontSize: 18), // Reduce font size for temperature
            ),
          ],
        ),
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  final List<Hour> hourlyForecasts;

  const HourlyForecast({required this.hourlyForecasts});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display loading indicator while fetching current time
        } else {
          final currentTime = snapshot.data as TimeOfDay;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyForecasts.length,
            itemBuilder: (context, index) {
              final hourForecast = hourlyForecasts[index];
              final isCurrent = _isCurrentHour(currentTime, hourForecast.time);
              return HourlyForecastCard(
                time: hourForecast.time,
                temperature: hourForecast.tempC,
                iconUrl: hourForecast.iconUrl,
                isCurrent: isCurrent,
              );
            },
          );
        }
      },
    );
  }

  Future<TimeOfDay> _getCurrentTime() async {
    final DateTime now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  bool _isCurrentHour(TimeOfDay currentTime, String hourTime) {
    final int currentHour = currentTime.hour;
    final int currentMinute = currentTime.minute;
    final List<String> timeParts =
        hourTime.split(' ')[1].split(':'); // Split to get only the time part
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    return currentHour == hour && currentMinute == minute;
  }
}
