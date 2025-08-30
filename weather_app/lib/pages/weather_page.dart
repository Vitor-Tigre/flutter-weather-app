import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  final WeatherService weatherService;

  WeatherPage(this.weatherService);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;
  String? _errorMessage;

  _fetchWeather() async {
    try {
      String city = await widget.weatherService.getCurrentCity();
      final weather = await widget.weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _errorMessage = null;
      });

    } catch(e) {
      setState(() {
        _weather = null;
        _errorMessage = e.toString();
      });
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
      backgroundColor: Color(0xFFB3E5FC),
      body: Center(
        child: _weather == null
        ? _errorMessage != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_off, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await _fetchWeather();
                  },
                  child: Text('Try Again'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Geolocator.openAppSettings();
                  },
                  child: Text('Open App Settings'),
                ),
              ],
            )
          : Lottie.asset(
            'assets/AbstractLoading07.json',
            width: 150,
            height: 150,
            fit: BoxFit.contain
            )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network('https://openweathermap.org/img/wn/${_weather?.icon}@4x.png'),
            Text(_weather?.city ?? 'loading...', style: TextStyle(fontSize: 24, color: Color(0XFF37474F), fontWeight: FontWeight.bold)),
            Text(_weather?.description ?? '[description]', style: TextStyle(fontSize: 16, color: Color(0XFF78909C), fontWeight: FontWeight.w400)),

            Text('${_weather?.temperature.round()}ºC', style: TextStyle(fontSize: 20, color: Color(0XFF37474F), fontWeight: FontWeight.w500))
          ]
        ),
      ),
    );
  }
}