import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/models/weather_models.dart';

class ApiService {
  static Future<WeatherModel> fetchWeatherModel(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
