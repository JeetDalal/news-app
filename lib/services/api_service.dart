import 'dart:convert';

import 'package:edu_assignment/modals/errorModal.dart';
import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // final apiKey='';
  final apiKey = dotenv.env['API_KEY'];
  Future<TopHeadlineModel> getTopHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return TopHeadlineModel.fromJson(body);
    } else {
      final errorBody = jsonDecode(response.body);
      final data = ErrorModal.fromJson(errorBody);
      throw Exception('Error');
    }
  }

  Future<everythingApiModal> getAllNews() async {
    String url =
        'https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return everythingApiModal.fromJson(body);
    }

    throw Exception('Error');
  }

  String handleError(ErrorModal data) {
    return data.message!;
  }
}
