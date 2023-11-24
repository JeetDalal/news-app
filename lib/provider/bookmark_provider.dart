import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:edu_assignment/services/shared_preference.dart';
import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  SharedPreferencesHelper sf = SharedPreferencesHelper();
  List<TopHeadlineModel> _topHeadBookmark = [];
  List<everythingApiModal> _topAllBookmark = [];

  List<TopHeadlineModel> get topHeadBookmarks {
    return [..._topHeadBookmark];
  }

  List<everythingApiModal> get topAllBookmark {
    return [..._topAllBookmark];
  }

  loadTopBookmarkItems() async {
    SharedPreferencesHelper sf = SharedPreferencesHelper();
    final List<TopHeadlineModel> items = await sf.loadItems();
    _topHeadBookmark = items;
    notifyListeners();
  }

  loadTopAllBookmarkItems() async {
    final List<everythingApiModal> items = await sf.loadAllItems();
    _topAllBookmark = items;
    notifyListeners();
  }

  addTopBookmarkItem(TopHeadlineModel item, BuildContext context) async {
    if (!_topHeadBookmark.any(
        (element) => element.articles![0].title == item.articles![0].title)) {
      _topHeadBookmark.add(item);
      await sf.saveItems(_topHeadBookmark).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item Added from bookmark')));
      });
    } else {
      _topHeadBookmark.removeWhere(
          (element) => element.articles![0].title == item.articles![0].title);
      await sf.saveAllItems(_topAllBookmark);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Item Removed from bookmark')));
    }
    notifyListeners();
  }

  addTopAllBookmarkItem(everythingApiModal item) async {
    if (!_topAllBookmark.any(
        (element) => element.articles![0].title == item.articles![0].title)) {
      _topAllBookmark.add(item);
      await sf.saveAllItems(_topAllBookmark);
    } else {
      _topAllBookmark.remove(item);
      await sf.saveAllItems(_topAllBookmark);
    }
    notifyListeners();
  }
}
