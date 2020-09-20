import 'package:chart_normal/subs.dart';
import 'package:chart_normal/subs_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatelessWidget {
  final List<Subscription> data =[
    Subscription(
      year: '2008',
      subscribers: 1000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),

    Subscription(
      year: '2009',
      subscribers: 2200,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),

    Subscription(
      year: '2010',
      subscribers: 3044,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: SubsChart(
            data: data,
          ),
        ),

      ),
    );
  }
}
