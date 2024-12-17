import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeRepository {
  final String baseUrl = "https://api.exchangerate.host/latest";
  final String apiKey = "de201448ea08c8eb4532904c0c756f00";

  // Fetch all currencies with exchange rates
  Future<Map<String, double>> fetchAllCurrencies() async {
    final url = Uri.parse("$baseUrl?base=EUR&access_key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Check if success is true
      if (data['success'] == true && data['rates'] != null) {
        final rates = data['rates'] as Map<String, dynamic>;
        return rates.map((key, value) => MapEntry(key, value.toDouble()));
      } else {
        final errorMessage = data['error']?['info'] ?? "Unknown API error occurred.";
        throw Exception("API Error: $errorMessage");
      }
    } else {
      throw Exception("Failed to fetch currencies. Status Code: ${response.statusCode}");
    }
  }
}