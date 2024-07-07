import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_models.dart';
import '../providers/weather_provider.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),  // App bar title
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              bool isTablet = constraints.maxWidth >= 600; // Determine if device is tablet
              return Center(
                child: weatherProvider.isLoading
                    ? const CircularProgressIndicator()     // Show loading indicator if data is loading
                    : weatherProvider.error != null
                        ? Text('Error: ${weatherProvider.error}')  // Show error message if there's an error
                        : weatherProvider.weather == null
                            ? const Text('No data available.')      // Show message if no weather data available
                            : _buildWeatherDetails(context, weatherProvider.weather!, isTablet),      // Show weather details if available
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<WeatherProvider>(context, listen: false).fetchWeather(cityName);       // Fetch weather data on refresh button press
        },
        child: const Icon(Icons.refresh),    // Refresh icon
      ),
    );
  }

  // Widget to build weather details UI
  Widget _buildWeatherDetails(BuildContext context, WeatherModel weather, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
            width: isTablet ? 150 : 100,
            height: isTablet ? 150 : 100,
          ),  // Weather icon
          const SizedBox(height: 16.0),     // Spacer
          Text(
            'City: ${weather.name}',          // Display city name
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: isTablet ? 24 : 20,       // Adjust font size for tablet and phone
                ),
          ),
          const SizedBox(height: 8.0),       // Spacer
          Text( 
            'Temperature: ${weather.temp.toStringAsFixed(1)}°C',    // Display temperature
            style: Theme.of(context).textTheme.bodyLarge?.copyWith( 
                  fontSize: isTablet ? 20 : 16,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Condition: ${weather.description}',       // Display  Condition
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(   
                  fontSize: isTablet ? 20 : 16,
                ),
          ),
          const SizedBox(height: 8.0), //spacer
          Text(
            'Humidity: ${weather.humidity}%',      // Display Humidity
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isTablet ? 20 : 16,
                ),
          ),
          const SizedBox(height: 8.0), //spacer
          Text(
            'Wind Speed: ${weather.windSpeed} m/s',   // Display Wind Speed
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isTablet ? 20 : 16,
                ),
          ),
        ],
      ),
    );
  }
}
