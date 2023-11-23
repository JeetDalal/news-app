import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/modals/top_headline.dart';
import 'package:edu_assignment/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/search_bar.dart';
import '../components/top_headlines.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController textController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              children: [
                Text(
                  'Discover',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            //search bar
            SearchBox(
              controller: textController,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'TOP HEADLINES🔥',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TopHeadlines(),
            Text(
              'ALL NEWS',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            FutureBuilder<everythingApiModal>(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          data.articles![index].urlToImage ??
                                              data.articles![0].urlToImage!,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
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
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
