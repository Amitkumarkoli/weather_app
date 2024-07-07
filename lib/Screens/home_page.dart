import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/weather_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App Home'),
        actions: [
          IconButton(
            onPressed: () {
              weatherProvider.clearSearchHistory();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(context, weatherProvider),
              const SizedBox(height: 20),
              _buildWeatherImage(),
              const SizedBox(height: 20),
              _buildSearchButton(context, weatherProvider),
              const SizedBox(height: 20),
              _buildSearchHistory(context, weatherProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, WeatherProvider weatherProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: weatherProvider.cityController,
              decoration: const InputDecoration(
                hintText: 'Enter city name',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              weatherProvider.cityController.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherImage() {
    return Image.asset(
      'assets/forecast_image.png',
      height: 150,
      width: 150,
    );
  }

  Widget _buildSearchButton(BuildContext context, WeatherProvider weatherProvider) {
    return ElevatedButton(
      onPressed: () {
        final cityName = weatherProvider.cityController.text;
        if (cityName.isNotEmpty) {
          weatherProvider.fetchWeather(cityName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeatherDetails(cityName: cityName),
            ),
          );
        }
      },
      child: const Text('Search Weather'),
    );
  }

  Widget _buildSearchHistory(BuildContext context, WeatherProvider weatherProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search History',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: weatherProvider.searchHistory.length,
          itemBuilder: (context, index) {
            final cityName = weatherProvider.searchHistory[index];
            return ListTile(
              title: Text(cityName),
              onTap: () {
                weatherProvider.cityController.text = cityName;
              },
            );
          },
        ),
      ],
    );
  }
}
