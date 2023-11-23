import 'dart:convert';

import 'package:edu_assignment/modals/errorModal.dart';
import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const apiKey = '6355e1e8879a47f3b02b008d172ff384';
  Future<TopHeadlineModel> getTopHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=${apiKey}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return TopHeadlineModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<everythingApiModal> getAllNews() async {
    String url =
        'https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=${apiKey}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return everythingApiModal.fromJson(body);
    }
    throw Exception('Error');
  }
}
