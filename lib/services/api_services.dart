import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/constants.dart'; // `baseUrl` and `apiKey` file 
import 'package:weather_app/models/weather_models.dart';

class ApiService {
  // Method to fetch WeatherModel data from the API based on city name
  static Future<WeatherModel> fetchWeatherModel(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric')); // HTTP GET request to fetch weather data

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body)); // Parse JSON response into WeatherModel object
    } else {
      throw Exception('Failed to load data'); // Throw exception if HTTP request fails
    }
  }
}
