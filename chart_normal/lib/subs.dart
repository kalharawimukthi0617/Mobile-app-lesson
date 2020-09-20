import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class Subscription{
  final String year;
  final int subscribers;
  final charts.Color barColor;

  Subscription({
    @required this.year,
    @required this.subscribers,
    @required this.barColor});
}