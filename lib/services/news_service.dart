import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static const String _apiKey =
      '872bc38198d945a0b87f2334cd642454'; // Your NewsAPI key

  Future<List<Article>> getTopHeadlines({String country = 'us'}) async {
    try {
      final url = '$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Unknown error';
        throw Exception('API Error ${response.statusCode}: $errorMessage');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
