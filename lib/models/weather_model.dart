// import 'package:flutter/rendering.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15,
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}

// {
//   "coord": {
//     "lon": 80.35,
//     "lat": 26.4667
//   },
//   "weather": [
//     {
//       "id": 800,
//       "main": "Clear",
//       "description": "clear sky",
//       "icon": "01n"
//     }
//   ],
//   "base": "stations",
//   "main": {
//     "temp": 308.66,
//     "feels_like": 306.32,
//     "temp_min": 308.66,
//     "temp_max": 308.66,
//     "pressure": 1002,
//     "humidity": 16,
//     "sea_level": 1002,
//     "grnd_leve"main"l": 988
//   },
//   "visibility": 10000,
//   "wind": {
//     "speed": 0.78,
//     "deg": 175,
//     "gust": 1.08
//   },
//   "clouds": {
//     "all": 1
//   },
//   "dt": 1747243156,
//   "sys": {
//     "country": "IN",
//     "sunrise": 1747180345,
//     "sunset": 1747228657
//   },
//   "timezone": 19800,
//   "id": 1267995,
//   "name": "Kanpur",
//   "cod": 200
// }
