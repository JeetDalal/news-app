import 'dart:convert';

import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String itemsKey = 'items';

  Future<List<TopHeadlineModel>> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString(itemsKey);

    if (itemsString != null) {
      final List<dynamic> decodedList = jsonDecode(itemsString);
      final List<TopHeadlineModel> items =
          decodedList.map((item) => TopHeadlineModel.fromJson(item)).toList();
      return items;
    } else {
      return [];
    }
  }

  Future<void> saveItems(List<TopHeadlineModel> itemList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> itemsMapList =
        itemList.map((item) => item.toJson()).toList();
    final String itemsString = jsonEncode(itemsMapList);

    prefs.setString(itemsKey, itemsString);
  }

  Future<List<everythingApiModal>> loadAllItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString(itemsKey);

    if (itemsString != null) {
      final List<Map<String, dynamic>> decodedList = jsonDecode(itemsString);
      final List<everythingApiModal> items =
          decodedList.map((item) => everythingApiModal.fromJson(item)).toList();
      return items;
    } else {
      return [];
    }
  }

  Future<void> saveAllItems(List<everythingApiModal> itemList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> itemsMapList =
        itemList.map((item) => item.toJson()).toList();
    final String itemsString = jsonEncode(itemsMapList);

    prefs.setString(itemsKey, itemsString);
  }
}
