import 'dart:convert';
import 'package:http/http.dart' as http;

class IPLocationService {
  // Uses ip-api.com, no API key required, for demo/small use only
  static Future<String?> getCityByIP() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return data['city'] as String?;
      }
    }
    return null;
  }
}