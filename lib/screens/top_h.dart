import 'package:edu_assignment/components/search_bar.dart';
import 'package:edu_assignment/components/top_headlines.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:edu_assignment/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreTopHeadLines extends StatefulWidget {
  MoreTopHeadLines({super.key});

  static const routeName = '/top-headline';

  @override
  State<MoreTopHeadLines> createState() => _MoreTopHeadLinesState();
}

TextEditingController _controller = TextEditingController();

class _MoreTopHeadLinesState extends State<MoreTopHeadLines> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TopHeadLineFilterProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 80,
          bottom: 50,
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
            TopHeading(),
            const SizedBox(
              height: 10,
            ),
            SearchBox(
              isForEverythingApi: false,
              controller: _controller,
              showFilter: true,
            ),
            FilteredTopHeadines(provider),
          ],
        ),
      ),
    );
  }
}

FutureBuilder<TopHeadlineModel> FilteredTopHeadines(
    TopHeadLineFilterProvider provider) {
  return FutureBuilder<TopHeadlineModel>(
      future: provider.getTopHeadlines(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data == null)
            return Center(
              child: Text('No Data'),
            );
          return SizedBox(
            height: MediaQuery.of(context).size.height * 3 / 4 - 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: data.articles!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TopHeadlineCard(
                    title: data.articles![index].title,
                    description: data.articles![index].description,
                    url: data.articles![index].url,
                    imageUrl: data.articles![index].urlToImage,
                    sourceName: data.articles![index].source!.name,
                    sourceId: data.articles![index].source!.id,
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
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
          return Center(child: const CircularProgressIndicator());
        }
      });
}
