import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

// my api key: 07c88c124e211064fcdb182acb1f77ea

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('07c88c124e211064fcdb182acb1f77ea');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json';
    switch (mainCondition.toLowerCase()) {
      case "clouds":
        return 'assets/cloud.json';
      case "mist":
        return 'assets/mist.json';
      case "smoke":
        return 'assets/mist.json';
      case "haze":
        return 'assets/mist.json';
      case "dust":
        return 'assets/sun_cloud.json';
      case "fog":
        return 'assets/mist.json';
      case "rain":
        return 'assets/cloud_rain.json';
      case "drizzle":
        return 'assets/sun_cloud_rain.json';
      case "shower rain":
        return 'assets/sun_cloud_rain.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // city name
          Text(_weather?.cityName ?? "Loading city ..."),

          // weather animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // temperature
          Text("${_weather?.temperature.round()} °C"),

          // weather condition
          Text(_weather?.mainCondition ?? ""),
        ]),
      ),
    );
  }
}
