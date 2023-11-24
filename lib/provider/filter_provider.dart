import 'dart:convert';
import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:edu_assignment/screens/top_h.dart';
import 'package:edu_assignment/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TopHeadLineFilterProvider with ChangeNotifier {
  List<String> availableSources = ['abc news', 'business-insider', 'bloomberg'];
  List<String> _sources = [];
  String _category = '';
  Map<String, dynamic> _params = {'apiKey': ApiService().apiKey};
  String _country = 'us';
  String _query = '';

  String get query {
    return _query;
  }

  Map<String, dynamic> get params {
    return {..._params};
  }

  String get country {
    return _country;
  }

  String get category {
    return _category;
  }

  List<String> get sources {
    return [..._sources];
  }

  setQuery(String q) {
    _query = q;
    notifyListeners();
  }

  setCountry(String country) {
    switch (country) {
      case 'India':
        _country == country ? _country = '' : _country = 'in';
        break;
      case 'japan':
        _country == country ? _country = '' : _country = 'jp';
        break;
      case 'china':
        _country == country ? _country = '' : _country = 'cn';
        break;
      case 'usa':
        _country == country ? _country = '' : _country = 'us';
        break;
      case 'uk':
        _country == country ? _country = '' : _country = 'ae';
        break;
      default:
        _country == country ? _country = '' : _country = 'in';
    }
    notifyListeners();
  }

  setCategory(String category) {
    _category == category ? _category = '' : _category = category;
    notifyListeners();
  }

  setSources(String source) {
    if (_sources.contains(source)) {
      _sources.remove(source);
    } else {
      _sources.add(source);
    }
    notifyListeners();
  }

  sourceClicked(String source, BuildContext context) {
    if (!availableSources.contains(source)) {
      availableSources.add(source);
    }
    _country = '';
    _category = '';
    _sources.clear();
    _sources.add(source);
    notifyListeners();
    final routeName = ModalRoute.of(context)!.settings.name;
    if (routeName != MoreTopHeadLines.routeName) {
      Navigator.of(context).pushNamed(MoreTopHeadLines.routeName);
    }
  }

  Future<TopHeadlineModel> getTopHeadlines({
    String? country,
    List<String>? sources,
    String? category,
  }) async {
    final baseUrl = 'newsapi.org';
    final path = '/v2/top-headlines';
    final apiKeyParam = 'apiKey=${ApiService().apiKey}';

    final uri = Uri.https(baseUrl, path, {
      'apiKey': ApiService().apiKey,
      if (_country != '') 'country': _country,
      if (_sources.isNotEmpty) 'sources': _sources.join(','),
      if (_category != '') 'category': _category,
      if (_query != '') 'q': _query
    });
    // final url =
    //     '$baseUrl?$apiKeyParam&$countriesParam&$sourcesParam&$categoriesParam';

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(response.body);
        return TopHeadlineModel.fromJson(data);
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      print(e);
      throw Exception('Error: $e');
    }
  }
}

class EverythingFilter with ChangeNotifier {
  String _query = '';
  DateTime? _fromDate = DateTime.now();
  DateTime? _toDate = DateTime.now();
  String _sortBy = 'publishedAt';

  String get query {
    return _query;
  }

  String get sortBy {
    return _sortBy;
  }

  DateTime? get fromDate {
    print(_fromDate);
    return _fromDate;
  }

  DateTime? get toDate {
    print(_toDate);
    return _toDate;
  }

  setQuery(String q) {
    _query = q;
    notifyListeners();
  }

  setFromDate(DateTime date) {
    _fromDate = date;
    notifyListeners();
  }

  setToDate(DateTime date) {
    _toDate = date;
    notifyListeners();
  }

  setSortby(String type) {
    _sortBy = type;
    notifyListeners();
  }

  Future<everythingApiModal> fetchEverything() async {
    final baseUrl = 'newsapi.org';
    final path = '/v2/everything';
    final apiKeyParam = 'apiKey=${ApiService().apiKey}';
// Format: 'yyyy-MM-dd'

    final uri = Uri.https(baseUrl, path, {
      'apiKey': ApiService().apiKey,
      'q': _query,
      if (sortBy != null) 'sortBy': _sortBy,
      if (_fromDate != null)
        'from': DateFormat('yyyy-MM-dd').format(_fromDate!),
      if (_toDate != null) 'to': DateFormat('yyyy-MM-dd').format(_toDate!),
    });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return everythingApiModal.fromJson(data);
      } else {
        throw Exception('Failed to load data from News API');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
