class Forecast {
  final List<ForecastDay> forecastDays;
  final CurrentDay currentDay;
  final WeatherLocation weatherLocation;
  final String humidity;
  final String feelsLike;
  final String windSpeed;

  Forecast({
    required this.forecastDays,
    required this.currentDay,
    required this.weatherLocation,
    required this.humidity,
    required this.feelsLike,
    required this.windSpeed,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastDays: (json['forecast']['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
      currentDay: CurrentDay.fromJson(json['current']),
      weatherLocation: WeatherLocation.fromJson(json['location']),
      humidity: json['current']['humidity'].toString(),
      feelsLike: json['current']['feelslike_c'].toString(),
      windSpeed: json['current']['wind_kph'].toString(),
    );
  }
}

class CurrentDay {
  final String tempC;
  final String tempF;
  final Condition condition;

  CurrentDay({
    required this.tempC,
    required this.tempF,
    required this.condition,
  });

  factory CurrentDay.fromJson(Map<String, dynamic> json) {
    return CurrentDay(
      tempC: json['temp_c'].toString(),
      tempF: json['temp_f'].toString(),
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class WeatherLocation {
  final String name;

  WeatherLocation({required this.name});

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(name: json['name']);
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
    );
  }
}

class ForecastDay {
  final String date;
  final List<Hour> hours;
  final Day day;

  ForecastDay({
    required this.day,
    required this.date,
    required this.hours,
  });

  factory ForecastDay.fromJson(Map json) {
    return ForecastDay(
      date: json['date'],
      hours: (json['hour'] as List).map((e) => Hour.fromJson(e)).toList(),
      day: Day.fromJson(json['day'] as Map),
    );
  }
}

class Hour {
  final String time;
  final double tempC;
  final String iconUrl;

  Hour({
    required this.time,
    required this.tempC,
    required this.iconUrl,
  });

  factory Hour.fromJson(Map json) {
    return Hour(
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      iconUrl: json['condition']['icon'],
    );
  }
}

class Day {
  final double maxTempC;
  final double minTempC;
  final String conditionText;
  final String conditionIcon;

  Day({
    required this.maxTempC,
    required this.minTempC,
    required this.conditionText,
    required this.conditionIcon,
  });

  factory Day.fromJson(Map json) {
    return Day(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
    );
  }
}
