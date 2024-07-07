# My Weather App

"My Weather" is a Flutter-based mobile application designed to provide users with real-time weather information. It allows users to check the current weather conditions, including temperature, humidity, wind speed, and more, for any desired location.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)

## Overview

"My Weather" is developed using Flutter, which allows for cross-platform compatibility, enabling users to access weather information on both Android and iOS devices. The app utilizes a provider-based state management approach to manage application state and weather data efficiently.

## Features

1. **Current Weather Information:** Display real-time weather data such as temperature, description, and icons.
2. **Search History:** Maintain a history of previous search queries for quick access.
3. **Responsive Design:** Ensure the app's UI adapts well to various screen sizes, including mobile phones and tablets.
4. **API Integration:** Utilize weather APIs to retrieve accurate and up-to-date weather information.

## Project Structure

The project follows a structured organization to maintain clarity and scalability:


- **`models/`**: Contains data models like `WeatherModel` for storing weather-related information.
- **`providers/`**: Includes `WeatherProvider` using the Provider package for state management.
- **`screens/`**: Houses UI screens such as `HomePage` and `WeatherDetails` for displaying weather information.
- **`services/`**: Implements `ApiService` for fetching weather data from external APIs.
- **`utils/`**: Stores `constants.dart` file for managing API keys and other constants.
- **`theme/`**: Defines `app_theme.dart` for consistent app styling and theming.
- **`main.dart`**: Entry point of the application where providers are initialized and MaterialApp is configured.

## Getting Started

To run "My Weather" app on your local machine, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AmitKumarkoli/weather_app.git
   cd your_weather_app
2. **Install dependencies:**
    ```bash
    flutter pub get
   
4. **API Key Configuration:**

  - **`Obtain a free API key from a weather provider (e.g., OpenWeatherMap, WeatherStack).
  - **`Replace the placeholder API key in constants.dart with your own key.
    
5. **Run the app:**
     ```bash
     flutter run
   
