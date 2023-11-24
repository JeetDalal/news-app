import 'package:edu_assignment/provider/bookmark_provider.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:edu_assignment/provider/source_provider.dart';
import 'package:edu_assignment/screens/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/top_headline.dart';
import '../services/api_service.dart';

class TopHeadlines extends StatelessWidget {
  final Axis axis;
  final double ht;
  const TopHeadlines({
    required this.ht,
    required this.axis,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopHeadlineModel>(
        future: ApiService().getTopHeadlines(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data == null) {
              print('Heelo');
              return Center(child: Text('No News'));
            } else {
              print(data.articles!.length);
              return SizedBox(
                height: ht,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: data.articles == null ? 0 : data.articles!.length,
                  scrollDirection: axis,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TopHeadlineCard(
                        description: data.articles![index].description,
                        title: data.articles![index].title,
                        imageUrl: data.articles![index].urlToImage,
                        url: data.articles![index].url,
                        sourceName: data.articles![index].source!.name,
                        sourceId: data.articles![index].source!.id,
                      ),
                    );
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
                child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://st.depositphotos.com/1006899/2650/i/450/depositphotos_26505551-stock-photo-error-metaphor.jpg',
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class TopHeadlineCard extends StatelessWidget {
  const TopHeadlineCard(
      {super.key,
      this.title,
      this.imageUrl,
      this.url,
      this.description,
      this.sourceName,
      this.sourceId});

  final String? title;
  final String? imageUrl;
  final String? url;
  final String? description;
  final String? sourceName;
  final String? sourceId;

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final sourceProvider = Provider.of<SourceProvider>(context);
    final topHeadlineProvider = Provider.of<TopHeadLineFilterProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(NewsDetail.routeName, arguments: {
          'title': title,
          'imageUrl': imageUrl,
          'url': url,
          'description': description,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                  // colorFilter: ,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageUrl ??
                        'https://images.unsplash.com/photo-1490730141103-6cac27aaab94?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Stack(children: [
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    bookmarkProvider.addTopBookmarkItem(
                        TopHeadlineModel(articles: [
                          Articles(
                              title: title,
                              urlToImage: imageUrl,
                              url: url,
                              description: description,
                              source: Source(id: sourceId, name: sourceName)),
                        ]),
                        context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      !bookmarkProvider.topHeadBookmarks.any(
                              (element) => element.articles![0].title == title)
                          ? Icons.book_outlined
                          : Icons.book,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              sourceId != null
                  ? Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        height: 60,
                        // width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    topHeadlineProvider.sourceClicked(
                                        sourceId!, context);
                                  },
                                  child: Text(sourceName!)),
                              IconButton(
                                  onPressed: () {
                                    if (sourceProvider.sources
                                        .contains(sourceName)) {
                                      sourceProvider.removeSource(sourceName!);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text('Source removed')));
                                    } else {
                                      sourceProvider.addSource(sourceName!);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text('Source Saved')));
                                    }
                                  },
                                  icon: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.red),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              !sourceProvider.sources
                                                      .contains(sourceName!)
                                                  ? 'save source'
                                                  : 'saved',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
          ),
          SizedBox(
              width: 350,
              height: 100,
              child: Text(
                title ?? '',
                // overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              )),
        ],
      ),
    );
  }
}
