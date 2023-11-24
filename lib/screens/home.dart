import 'package:edu_assignment/components/drop_down.dart';
import 'package:edu_assignment/components/my_date_picker.dart';
import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:edu_assignment/screens/bookmark.dart';
import 'package:edu_assignment/screens/top_h.dart';
import 'package:edu_assignment/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/search_bar.dart';
import '../components/top_headlines.dart';
import '../provider/bookmark_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// TextEditingController textEditingController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  static const id = '/home';

  bool isTextEmpty = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isTextEmpty = textEditingController.text.isEmpty;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var bookmark = Provider.of<BookmarkProvider>(context, listen: false);
      bookmark.loadTopBookmarkItems();
    });

    // Add a listener to the text controller
    textEditingController.addListener(() {
      // Update the state based on the text emptiness
      setState(() {
        isTextEmpty = textEditingController.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EverythingFilter>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 50,
          bottom: 50,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(BookmarkScreen.routeName);
                    },
                    icon: Icon(
                      Icons.bookmark,
                      size: 40,
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            //search bar
            SearchBox(
              isForEverythingApi: true,
              showFilter: false,
              controller: textEditingController,
            ),
            const SizedBox(
              height: 20,
            ),

            isTextEmpty
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search Results',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Sort By',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MyDropdown(),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyDatePicker(
                                isFrom: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyDatePicker(
                                isFrom: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<everythingApiModal>(
                          future: provider.fetchEverything(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              if (data!.articles!.isEmpty) {
                                return const Center(
                                  child: Text('NO MATCH FOUND'),
                                );
                              }
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 3 / 4 -
                                        50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: data!.articles!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TopHeadlineCard(
                                        title: data.articles![index].title,
                                        description:
                                            data.articles![index].description,
                                        url: data.articles![index].url,
                                        imageUrl:
                                            data.articles![index].urlToImage,
                                        sourceId:
                                            data.articles![index].source!.id,
                                        sourceName:
                                            data.articles![index].source!.name,
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
                              return const CircularProgressIndicator();
                            }
                          }),
                    ],
                  ),

            Visibility(
              visible: isTextEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopHeading(),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MoreTopHeadLines.routeName);
                      },
                      child: ViewMore()),
                ],
              ),
            ),
            isTextEmpty
                ? const TopHeadlines(
                    ht: 350,
                    axis: Axis.horizontal,
                  )
                : Container(),
            textEditingController.text.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ALL NEWS',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  )
                : Container(),
            textEditingController.text.isEmpty
                ? FutureBuilder<everythingApiModal>(
                    future: ApiService().getAllNews(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        return SizedBox(
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.articles!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            // colorFilter: ,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              data.articles![index]
                                                      .urlToImage ??
                                                  data.articles![0].urlToImage!,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Stack(children: [
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.book_outlined,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                            width: 250,
                                            height: 50,
                                            child: Text(
                                              data.articles![index].title!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(fontSize: 20),
                                            )),
                                        SizedBox(
                                            width: 250,
                                            height: 45,
                                            child: Text(
                                              '${data.articles![index].description!.substring(0, 40)}...',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                            )),
                                      ],
                                    ),
                                  ],
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
                        return const CircularProgressIndicator();
                      }
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}

class TopHeading extends StatelessWidget {
  const TopHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'TOP HEADLINES🔥',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class ViewMore extends StatelessWidget {
  const ViewMore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'View More',
          style: GoogleFonts.palanquin(color: Colors.grey, fontSize: 14),
        ),
        Icon(
          Icons.arrow_forward,
          color: Colors.grey,
        ),
      ],
    );
  }
}
