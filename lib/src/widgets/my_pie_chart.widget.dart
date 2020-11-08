import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  static const pi = 3.1416;

  MyPieChart(this.seriesList, {this.animate});

  factory MyPieChart.createChart(List<PieChartSegment> data) {
    return new MyPieChart(
      _setData(data),
      animate: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 0,
        // startAngle: 4/5 * pi,
        // arcLength: 7/5 * pi
      )
    );
  }

  static List<charts.Series<PieChartSegment, String>> _setData(List<PieChartSegment> data) {
    return [
      new charts.Series<PieChartSegment, String>(
        id: 'Segments',
        domainFn: (PieChartSegment segment, _) => segment.segment,
        measureFn: (PieChartSegment segment, _) => segment.size,
        colorFn: (PieChartSegment segment, _) => segment.color,
        data: data
      )
    ];
  }
}

class PieChartSegment {
  String segment;
  int size;
  charts.Color color;

  PieChartSegment(this.segment, this.size, this.color);
}