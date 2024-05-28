import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/forecast.dart';

class FourteenDayForecastCard extends StatelessWidget {
  final List<ForecastDay> forecastDays;

  const FourteenDayForecastCard({required this.forecastDays});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: forecastDays.length,
              itemBuilder: (context, index) {

                final day = forecastDays[index];
                return ListTile(
                  title: Text(day.date),
                  subtitle: Row(
                    children: [
                      // Text('Humidity: ${day.day.humidity}%'),
                      const SizedBox(width: 8),
                      Image.network(
                        'https:${day.day.conditionIcon}',
                        width: 44,
                        height: 44,
                      ),
                      const SizedBox(width: 8),
                      Text('Max: ${day.day.maxTempC.toStringAsFixed(1)}°C'),
                      const SizedBox(width: 8),
                      Text('Min: ${day.day.minTempC.toStringAsFixed(1)}°C'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
