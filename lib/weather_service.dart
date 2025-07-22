import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '7de4e720e5fd0d4af95889808f256313';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>> fetchWeatherByCity({required String city}) async {
    final url = '$_baseUrl?q=$city&units=metric&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return _parseWeather(jsonDecode(response.body));
    } else {
      throw Exception('City not found');
    }
  }

  static Map<String, dynamic> _parseWeather(Map<String, dynamic> data) {
    return {
      'city': data['name'],
      'condition': data['weather'][0]['main'],
      'temp': (data['main']['temp'] as num).toDouble(),
    };
  }
}