import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_models.dart';
import '../utils/constants.dart'; // this file contains `baseUrl` and `apiKey`

class WeatherProvider with ChangeNotifier {
  TextEditingController cityController = TextEditingController(); // Controller for the city input field
  WeatherModel? _weather; // Weather data model
  bool _isLoading = false; // Loading indicator
  String? _error; // Error message
  List<String> _searchHistory = []; // List to store search history

  // Getters for accessing private variables
  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get searchHistory => _searchHistory;

  WeatherProvider() {
    _loadSearchHistory(); // Load search history on initialization
  }

  // Method to fetch weather data from API
  Future<void> fetchWeather(String cityName) async {
    _isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners (UI) to update

    try {
      final response = await http.get(
          Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric')); // API call to fetch weather data

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body); // Decode JSON response
        _weather = WeatherModel.fromJson(jsonData); // Parse JSON into WeatherModel object
        _error = null; // Reset error state
        _saveSearchHistory(cityName); // Save searched city to history
      } else {
        _error = 'Failed to load weather data'; // Set error message if API call fails
      }
    } catch (e) {
      _error = 'Failed to connect to the server'; // Set error message if exception occurs
    }

    _isLoading = false; // Set loading state to false
    notifyListeners(); // Notify listeners (UI) to update
  }

  // Method to clear search history
  void clearSearchHistory() {
    _searchHistory.clear(); // Clear search history list
    notifyListeners(); // Notify listeners (UI) to update
  }

  // Method to simulate loading search history from storage (e.g., SharedPreferences)
  void _loadSearchHistory() {
    // Replace with actual implementation to load from persistent storage
    _searchHistory = []; // Initialize search history (simulate loading)
  }

  // Method to save searched city to search history
  void _saveSearchHistory(String cityName) {
    // Replace with actual implementation to save to persistent storage
    if (!_searchHistory.contains(cityName)) {
      _searchHistory.insert(0, cityName); // Insert searched city at the beginning of the list
      // Example: Limit history length if desired
      // _searchHistory = _searchHistory.take(5).toList(); // Limit to 5 items
      notifyListeners(); // Notify listeners (UI) to update
    }
  }

  @override
  void dispose() {
    cityController.dispose(); // Dispose of TextEditingController to avoid memory leaks
    super.dispose();
  }
}
