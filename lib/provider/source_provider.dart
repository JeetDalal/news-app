import 'package:flutter/material.dart';

class SourceProvider with ChangeNotifier {
  List<String> _sources = [];

  List<String> get sources {
    return [..._sources];
  }

  addSource(String source) {
    _sources.add(source);
    notifyListeners();
  }

  removeSource(String source) {
    _sources.remove(source);
    notifyListeners();
  }
}
