import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  String? userLang;
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String city) async {
    String url = '$BASE_URL?q=$city&appid=$apiKey&units=metric&lang=$userLang';
    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200) {
        throw Exception('Failed to fetch weather data. Please check your internet connection or try again later. Error ${res.statusCode}');
      }

      return Weather.fromJson(jsonDecode(res.body));
    } catch (e) {
      print('error during API call: $e');
      throw Exception('Failed to fetch weather data. Please check your internet connection or try again later.');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied. Please enable it in settings.');
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city;
    if (placemarks[0].locality == '' || placemarks[0].locality == null) {
      city = placemarks[0].subAdministrativeArea;
    } else {
      city = placemarks[0].locality;
    }

    return city ?? "";
  }
}