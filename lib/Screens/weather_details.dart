import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_models.dart';
import '../providers/weather_provider.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: Center(
        child: weatherProvider.isLoading
            ? const CircularProgressIndicator()
            : weatherProvider.error != null
                ? Text('Error: ${weatherProvider.error}')
                : weatherProvider.weather == null
                    ? const Text('No data available.')
                    : _buildWeatherDetails(context, weatherProvider.weather!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          weatherProvider.fetchWeather(cityName);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildWeatherDetails(BuildContext context, WeatherModel weather) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 16.0),
          Text(
            'City: ${weather.name}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Temperature: ${weather.temp.toStringAsFixed(1)}°C',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Condition: ${weather.description}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Humidity: ${weather.humidity}%',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Wind Speed: ${weather.windSpeed} m/s',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
