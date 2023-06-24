import 'package:flutter/material.dart';
import 'package:wheater_app/model/api_weather.dart';
import 'package:wheater_app/model/weather.model.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _weather;
  String _error = '';
  bool _isLoading = false;

  Weather? get weather => _weather;
  String get error => _error;
  bool get loading => _isLoading;

  Future<void> fetchWeather(String city) async {
    try {
      _isLoading = true;
      notifyListeners();

      final api = WeatherApi();
      final weatherData = await api.getWeather(city);

      _weather = Weather(
          main: weatherData['main'],
          description: weatherData['description'],
          temp: weatherData['temp'],
          wind: weatherData['wind']);
      _isLoading = false;
      _error = "";
    } catch (e) {
      _isLoading = false;
      _error = "Data Tidak di temukan";
    }
    notifyListeners();
  }
}
