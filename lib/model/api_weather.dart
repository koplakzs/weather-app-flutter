import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String key = dotenv.env['API_KEY']!;

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return {
        'main': jsonData['weather'][0]['main'],
        'description': jsonData['weather'][0]['description'],
        'temp': jsonData['main']['temp'],
        'wind': jsonData['wind']['speed']
      };
    } else {
      throw Exception("Failed");
    }
  }
}
