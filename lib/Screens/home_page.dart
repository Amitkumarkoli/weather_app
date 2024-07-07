import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/weather_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the WeatherProvider using Provider.of
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // Centered title in the app bar
        title: const Center(child: Text('Weather App Home')),
        actions: [
          // Clear search history button in the app bar
          IconButton(
            onPressed: () {
              weatherProvider.clearSearchHistory();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Checking if the screen size is tablet or not
          bool isTablet = constraints.maxWidth >= 600;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Building the search bar UI
                  _buildSearchBar(context, weatherProvider),
                  const SizedBox(height: 20), // Spacer
                  // Building the weather image UI
                  _buildWeatherImage(isTablet),
                  const SizedBox(height: 20), // Spacer
                  // Building the search button UI
                  _buildSearchButton(context, weatherProvider),
                  const SizedBox(height: 20), // Spacer
                  // Building the search history UI
                  _buildSearchHistory(context, weatherProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget for building the search bar
  Widget _buildSearchBar(BuildContext context, WeatherProvider weatherProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              final cityName = weatherProvider.cityController.text;
              if (cityName.isNotEmpty) {
                weatherProvider.fetchWeather(cityName);
                // Navigate to WeatherDetails screen on button press
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherDetails(cityName: cityName),
                  ),
                );          
              }
            },
            icon: const Icon(Icons.search),
          ),
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

  // Widget for building the weather image
  Widget _buildWeatherImage(bool isTablet) {
    return Center(
      child: Image.asset(
        'assets/forecast_image.png',
        height: isTablet ? 300 : 150,
        width: isTablet ? 300 : 150,
      ),
    );
  }

  // Widget for building the search button
  Widget _buildSearchButton(BuildContext context, WeatherProvider weatherProvider) {
    return ElevatedButton(
      onPressed: () {
        final cityName = weatherProvider.cityController.text;
        if (cityName.isNotEmpty) {
          weatherProvider.fetchWeather(cityName);
          // Navigate to WeatherDetails screen on button press
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeatherDetails(cityName: cityName),
            ),
          );          
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(200, 50), // Set button size
      ),
      child: const Text('Search Weather'), // Button text
    );
  }

  // Widget for building the search history list
  Widget _buildSearchHistory(BuildContext context, WeatherProvider weatherProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Search History', // Title for search history
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10), // Spacer
        // List view for displaying search history
        ListView.builder(
          shrinkWrap: true,
          itemCount: weatherProvider.searchHistory.length,
          itemBuilder: (context, index) {
            final cityName = weatherProvider.searchHistory[index];
            return ListTile(
              title: Center(child: Text(cityName)), // Display city name
              onTap: () {
                weatherProvider.cityController.text = cityName; // Set text in search bar on tap
              },
            );
          },
        ),
      ],
    );
  }
}
