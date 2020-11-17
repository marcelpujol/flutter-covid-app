import 'package:auto_size_text/auto_size_text.dart';
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
          color: Color.fromRGBO(45, 47, 57, 1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(segments[index].segment,
                  wrapWords: false, 
                  style: TextStyle(
                    color: Color.fromARGB(
                      segments[index].color.a, 
                      segments[index].color.r, 
                      segments[index].color.g,
                      segments[index].color.b
                    ), 
                    fontWeight: FontWeight.bold, 
                    fontSize: 14
                  )
                ),
                SizedBox(height: 10),
                AutoSizeText(segments[index].size.toString(),
                    wrapWords: false,
                    style: TextStyle(
                      fontWeight: FontWeight.w400, 
                      color: Colors.white, 
                      fontSize: 14
                      )
                  )
              ]
            )
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
              color: charts.MaterialPalette.white,
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