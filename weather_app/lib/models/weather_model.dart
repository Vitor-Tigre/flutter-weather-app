class Weather {
  final String city;
  final double temperature;
  final String codition;
  final String description;

  Weather({
    required this.city,
    required this.temperature,
    required this.codition,
    required this.description
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(city: json['name'], temperature: json['main']['temp'].toDouble(), codition: json['weather'][0]['main'], description: json['weather'][0]['description']);
  }
}
