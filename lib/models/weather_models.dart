class WeatherModel {
  final String name; // City name
  final double temp; // Temperature
  final String description; // Weather description
  final String icon; // Weather icon code
  final int humidity; // Humidity percentage
  final double windSpeed; // Wind speed in meters per second

  // Constructor to initialize WeatherModel with required parameters
  WeatherModel({
    required this.name,
    required this.temp,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  // Factory method to create WeatherModel instance from JSON data
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['name'], // Extract city name from JSON
      temp: json['main']['temp'].toDouble(), // Extract temperature from JSON and convert to double
      description: json['weather'][0]['description'], // Extract weather description from JSON
      icon: json['weather'][0]['icon'], // Extract weather icon code from JSON
      humidity: json['main']['humidity'], // Extract humidity from JSON
      windSpeed: json['wind']['speed'].toDouble(), // Extract wind speed from JSON and convert to double
    );
  }
}
