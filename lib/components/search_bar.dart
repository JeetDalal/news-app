import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:edu_assignment/screens/top_h.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController controller;
  final bool showFilter;
  final bool isForEverythingApi;
  SearchBox({
    required this.isForEverythingApi,
    required this.showFilter,
    required this.controller,
    super.key,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  List<Map<String, dynamic>> _countries = [
    {'India': 'in'},
    {'usa': 'us'},
    {'japan': 'jp'},
    {'china': 'cn'},
    {'berlin': 'be'}
  ];

  List<String> _categories = [
    'health',
    'technology',
    'general',
    'science',
    'sport',
    'entertainment',
    'business'
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TopHeadLineFilterProvider>(context);
    final everythingProvider = Provider.of<EverythingFilter>(context);
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              onChanged: (val) {
                widget.isForEverythingApi
                    ? everythingProvider.setQuery(val)
                    : provider.setQuery(val);
              },
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Icon(
                    Icons.search,
                  ),
                ),
                hintText: 'Search for news...',
                border: InputBorder.none,
              ),
            )),
            widget.showFilter
                ? InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
                          isScrollControlled: true,
                          // isDismissible: false,
                          builder: (context) {
                            final provider =
                                Provider.of<TopHeadLineFilterProvider>(context);
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 3 / 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 30,
                                ),
                                child: ListView(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Filters',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 25),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Category (single)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: List.generate(
                                          _categories.length, (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            provider.setCategory(
                                                _categories[index]);
                                            FilteredTopHeadines(provider);
                                          },
                                          child: ListTile(
                                            trailing: _categories[index] ==
                                                        provider.category &&
                                                    provider.category != ''
                                                ? Icon(
                                                    Icons.check_circle_outlined)
                                                : null,
                                            title: Text(
                                              _categories[index],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Country (single)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: List.generate(_countries.length,
                                          (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            provider.setCountry(
                                                _countries[index].keys.first);
                                          },
                                          child: ListTile(
                                            trailing: _countries[index]
                                                            .values
                                                            .first ==
                                                        provider.country &&
                                                    provider.country != ''
                                                ? Icon(
                                                    Icons.check_circle_outlined)
                                                : null,
                                            title: Text(
                                              _countries[index].keys.first,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Sources (multiple)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: List.generate(
                                          provider.availableSources.length,
                                          (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            provider.setSources(provider
                                                .availableSources[index]);
                                          },
                                          child: ListTile(
                                            title: Text(
                                              provider.availableSources[index],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.red[400],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(Icons.filter_alt_sharp),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
