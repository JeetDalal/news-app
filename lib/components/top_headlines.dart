import 'package:flutter/material.dart';

import '../modals/top_headline.dart';
import '../services/api_service.dart';

class TopHeadlines extends StatelessWidget {
  const TopHeadlines({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopHeadlineModel>(
        future: ApiService().getTopHeadlines(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: data!.articles!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        SizedBox(
                            width: 350,
                            child: Text(
                              data.articles![index].title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20),
                            )),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
