import 'package:edu_assignment/modals/everything_api_modal.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyDatePicker extends StatefulWidget {
  final bool isFrom;
  // final DateTime displayDate;

  MyDatePicker({required this.isFrom});

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate =
      DateTime.now(); // Default value, can be changed based on user selection

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
    );

    if (picked != null && picked != selectedDate) {
      final provider = Provider.of<EverythingFilter>(context, listen: false);
      widget.isFrom == true
          ? provider.setFromDate(picked)
          : provider.setToDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EverythingFilter>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Text(
            '${widget.isFrom ? 'From Date' : 'To Date'}: ${DateFormat("dd-MM-yyyy").format(widget.isFrom ? provider.fromDate! : provider.toDate!)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
