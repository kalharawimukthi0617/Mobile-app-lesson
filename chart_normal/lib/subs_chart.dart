import 'package:chart_normal/subs.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class SubsChart extends StatelessWidget {
  final List<Subscription> data;

  SubsChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<Subscription,String>> series=[
      charts.Series(
        id: "sub",
        data: data,
        domainFn: (Subscription series, _)=> series.year,
        measureFn: (Subscription series, _) =>series.subscribers,
        colorFn: (Subscription series, _) =>series.barColor,
      )//subscribers
    ];
    return charts.BarChart(series, animate: true,);//or BarChart
  }
}
