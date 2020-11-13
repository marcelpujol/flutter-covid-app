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

  static Widget getLegend(List<PieChartSegment> segments, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.height / 700,
      physics: new NeverScrollableScrollPhysics(),
      children: List.generate(segments.length, (index) {
        return Card(
          elevation: 4,
          color: Color.fromARGB(
            segments[index].color.a, 
            segments[index].color.r, 
            segments[index].color.g,
            segments[index].color.b
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(segments[index].segment, 
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                  fontSize: 20
                )
              ),
              SizedBox(height: 10),
              Text(segments[index].size.toString(), 
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                  fontSize: 20
                  )
              )
            ]
          )
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 60,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.auto,
            insideLabelStyleSpec: new charts.TextStyleSpec(
              fontSize: 18,
              color: charts.MaterialPalette.white
            ),
            outsideLabelStyleSpec: new charts.TextStyleSpec(
              fontSize: 15,
              color: charts.MaterialPalette.black,
            )
          )
        ]
        // startAngle: 4/5 * pi,
        // arcLength: 7/5 * pi
      )
    );
  }

  static List<charts.Series<PieChartSegment, String>> _setData(List<PieChartSegment> data) {
    int totalCases = 0;
    for (PieChartSegment datum in data) {
      totalCases += datum.size;
    }

    return [
        new charts.Series<PieChartSegment, String>(
          id: 'Segments',
          domainFn: (PieChartSegment segment, _) => segment.segment,
          measureFn: (PieChartSegment segment, _) => segment.size,
          colorFn: (PieChartSegment segment, _) => segment.color,
          data: data,
          labelAccessorFn: (PieChartSegment segment, _) => ( _getPercentatge(segment, totalCases))
        )
    ];
  }
}

  String _getPercentatge(PieChartSegment segment, int total) {
    if (segment.size == 0) return '0%';
    else {
      int value = (segment.size * 100 / total).round();
      return '$value %';
    }
  }

class PieChartSegment {
  String segment;
  int size;
  charts.Color color;

  PieChartSegment(this.segment, this.size, this.color);
}