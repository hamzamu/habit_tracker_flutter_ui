import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker_ui_hive/data/datetime.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary(
      {super.key, required this.datasets, required this.startDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: HeatMap(
          startDate: createDateTimeObject(startDate),
          endDate: DateTime.now().add(Duration(days: 0)),
          datasets: datasets,
          scrollable: true,
          textColor: Colors.white,
          size: 30,
          showText: true,
          onClick: (value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.toString())));
          },
          colorsets: {1: Colors.amberAccent, 2: Colors.black38}),
    );
  }
}
