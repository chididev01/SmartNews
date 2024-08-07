import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsModel {
  static const String _apiKey = '6fca2f14b316b1220ea5827515a0b3ca';
  static const String _baseUrl = 'https://gnews.io/api/v4/search';

  static Future<List<Map<String, String>>> fetchArticles(String interest) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?q=$interest&token=$_apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<Map<String, String>> articles = (data['articles'] as List).map((article) {
          return {
            'title': article['title'] as String,
            'url': article['url'] as String,
          };
        }).toList();
        return articles;
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load news articles');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load news articles');
    }
  }
}
