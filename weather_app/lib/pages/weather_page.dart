import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('c24cd5b2f824e0172c4fac058738658a');
  Weather? _weather;

  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(_weather?.city ?? 'loading...'),

          Text('${_weather?.temperature.round()}ºC')
        ],
      ),
    );
  }
}