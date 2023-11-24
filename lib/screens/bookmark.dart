import 'package:edu_assignment/components/top_headlines.dart';
import 'package:edu_assignment/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  static const routeName = '/bookmark-screen';

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BookmarkProvider().loadTopAllBookmarkItems();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 20,
          right: 20,
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text(
              'Favourite Top Headlines',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 3 / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: bookmarkProvider.topHeadBookmarks.length,
                itemBuilder: (context, index) {
                  print(bookmarkProvider.topHeadBookmarks.length);
                  final data = bookmarkProvider.topHeadBookmarks[index];
                  return TopHeadlineCard(
                    imageUrl: data.articles![0].urlToImage,
                    url: data.articles![0].url,
                    title: data.articles![0].title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
