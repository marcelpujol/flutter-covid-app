import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/global_incidence.dart';
import 'package:flutter_covid_app/src/widgets/my_grouped_bar_chart.widget.dart';
import 'package:intl/intl.dart';

import 'package:flutter_covid_app/src/providers/global_incidence.provider.dart';
import 'package:flutter_covid_app/src/providers/incidence_by_region.provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_covid_app/src/models/global_incidences.dart';

class GlobalPage extends StatelessWidget {
  final incidenceByRegionProvider = new IncidenceByRegionProvider();
  final globalIncidenceProvider = new GlobalIncidenceProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: _getGlobalChart(context)
    );
  }

  Widget _getGlobalChart(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: globalIncidenceProvider.getGlobalIncidence(),
      builder: (BuildContext context, AsyncSnapshot<GlobalIncidences> snapshot) {
        if (snapshot.hasData) {
          var chartSeries = _defineChartSeries(snapshot.data);
          return _defineGlobalChart(chartSeries);
        }
        return Container(
          height: _screenSize.height * 0.5,
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      }
    );
  }

  List<MyBarChartSerie> _defineChartSeries(GlobalIncidences globalIncidences) {
    List<MyBarChartSerie> allSeries = new List<MyBarChartSerie>();
    MyBarChartSerie confirmedData = new MyBarChartSerie('Confirmed', 0, new List<MyBarChartData>());
    MyBarChartSerie deathsData = new MyBarChartSerie('Deaths', 0, new List<MyBarChartData>());
    MyBarChartSerie recoveredData = new MyBarChartSerie('Recovered', 0, new List<MyBarChartData>());

    for (GlobalIncidence incidence in globalIncidences.data) {
      String date = new DateFormat('dd/MM/yy').format(incidence.date);
      confirmedData.data.add(new MyBarChartData(
        date, 
        incidence.dailyConfirmed, 
        charts.MaterialPalette.purple.shadeDefault
      ));
      confirmedData.totalSerie += incidence.dailyConfirmed; 
      
      recoveredData.data.add(new MyBarChartData(
        date, 
        incidence.dailyRecovered, 
        charts.MaterialPalette.green.shadeDefault
      ));
      recoveredData.totalSerie += incidence.dailyRecovered;

      deathsData.data.add(new MyBarChartData(
        date, 
        incidence.dailyDeads, 
        charts.MaterialPalette.red.shadeDefault
      ));
      deathsData.totalSerie += incidence.dailyDeads;
    }

    allSeries.add(confirmedData);
    allSeries.add(recoveredData);
    allSeries.add(deathsData);
    return allSeries;
  }

  Widget _defineGlobalChart(List<MyBarChartSerie> series) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: MyGroupedBarChart.createChart(series)
          ),
          Expanded(
            flex: 2,
            child: MyGroupedBarChart.getLegend(series),
          )
        ]
      )
    );
  }
}