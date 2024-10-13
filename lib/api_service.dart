import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<String>> generateEmail(String url) async {
    final response =
        await http.get(Uri.parse('$baseUrl/generate_email/?url=$url'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<String>.from(
          data['emails']); // Assuming emails are returned as a list
    } else {
      throw Exception('Failed to load emails');
    }
  }
}
