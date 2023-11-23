import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  const SearchBox({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                ),
                hintText: 'Search for news...',
                border: InputBorder.none,
              ),
            )),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.filter_alt_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
