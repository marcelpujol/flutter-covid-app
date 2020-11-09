import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MyGroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  MyGroupedBarChart(this.seriesList, {this.animate});

  factory MyGroupedBarChart.createChart(List<MyBarChartSerie> series) {
    return new MyGroupedBarChart(
      _setData(series),
      animate: true
    );
  }

  static Widget getLegend(List<MyBarChartSerie> series) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: series.length,
      physics: new NeverScrollableScrollPhysics(),
      children: List.generate(3, (index) {
        return Card(
          elevation: 4,
          color: Color.fromARGB(
            series[index].data[0].color.a, 
            series[index].data[0].color.r, 
            series[index].data[0].color.g,
            series[index].data[0].color.b
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(series[index].serieId, 
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                  fontSize: 20
                )
              ),
              SizedBox(height: 10),
              Text(series[index].totalSerie.toString(), 
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
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped
    );
  }

  static List<charts.Series<MyBarChartData, String>> _setData(List<MyBarChartSerie> series) {
    var returnedSeries = new List<charts.Series<MyBarChartData, String>>();
    for (var serie in series) {
      returnedSeries.add(
        new charts.Series<MyBarChartData, String>(
          id: serie.serieId,
          domainFn: (MyBarChartData incidence, _) => incidence.label,
          measureFn: (MyBarChartData incidence, _) => incidence.value,
          colorFn: (MyBarChartData incidence, _) => incidence.color,
          data: serie.data
        )
      );
    }
    return returnedSeries;
  }
}

class MyBarChartSerie {
  String serieId;
  int totalSerie;
  List<MyBarChartData> data = new List<MyBarChartData>();

  MyBarChartSerie(this.serieId, this.totalSerie, this.data);
}


class MyBarChartData {
  final String label;
  final int value;
  charts.Color color;

  MyBarChartData(this.label, this.value, this.color);
}