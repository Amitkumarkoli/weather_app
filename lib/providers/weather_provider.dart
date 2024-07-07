import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_models.dart';
import '../utils/constants.dart';

class WeatherProvider with ChangeNotifier {
  TextEditingController cityController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _error;
  List<String> _searchHistory = [];

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get searchHistory => _searchHistory;

  WeatherProvider() {
    _loadSearchHistory();
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
          Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _weather = WeatherModel.fromJson(jsonData);
        _error = null;
        _saveSearchHistory(cityName);
      } else {
        _error = 'Failed to load weather data';
      }
    } catch (e) {
      _error = 'Failed to connect to the server';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  void _loadSearchHistory() {
    // Simulating loading from persistent storage (e.g., SharedPreferences)
    // Replace with actual implementation if using persistent storage
    _searchHistory = []; // Load from storage
  }

  void _saveSearchHistory(String cityName) {
    // Simulating saving to persistent storage (e.g., SharedPreferences)
    // Replace with actual implementation if using persistent storage
    if (!_searchHistory.contains(cityName)) {
      _searchHistory.insert(0, cityName); // Insert at the beginning of the list
      // Limit history length if desired
      // _searchHistory = _searchHistory.take(5).toList(); // Example: limit to 5 items
      notifyListeners();
    }
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }
}
