import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EverythingFilter>(context);
    var selectedSortBy = provider.sortBy;
    return DropdownButton<String>(
      value: selectedSortBy,
      items: const [
        DropdownMenuItem(
          value: 'relevancy',
          child: Text('Relevancy'),
        ),
        DropdownMenuItem(
          value: 'popularity',
          child: Text('Popularity'),
        ),
        DropdownMenuItem(
          value: 'publishedAt',
          child: Text('Published At'),
        ),
      ],
      onChanged: (value) {
        provider.setSortby(value!);
      },
    );
  }
}
