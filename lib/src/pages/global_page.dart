import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/global_incidence.dart';
import 'package:flutter_covid_app/src/widgets/my_date_picker.widget.dart';
import 'package:flutter_covid_app/src/widgets/my_grouped_bar_chart.widget.dart';
import 'package:intl/intl.dart';

import 'package:flutter_covid_app/src/providers/global_incidence.provider.dart';
import 'package:flutter_covid_app/src/models/global_incidences.dart';
import 'package:charts_flutter/flutter.dart' as charts; 
import 'package:flutter_covid_app/src/constants/constants.dart' as Constants;

class GlobalPage extends StatefulWidget {
  GlobalPageState createState() {
    return new GlobalPageState();
  }
}


class GlobalPageState extends State<GlobalPage> {
  final globalIncidenceProvider = new GlobalIncidenceProvider();
  Future<GlobalIncidences> _globalIncidence;
  String _initialDate = '2020-04-01';
  String _finalDate = '2020-04-07';

  @override
  void initState() {
      super.initState();
      _getInicidenceData();
  }

  onInitialDateChanged(String initialDate) {
    setState(() {
      _initialDate = initialDate;
      _getInicidenceData();
    });
  }

  onFinalDateChanged(String finalDate) {
    setState(() {
      _finalDate = finalDate;
      _getInicidenceData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
     child: Column(
       children: [
         _getDates(context),
         _getGlobalChart(context)
       ]
     ),
    );
  }

  void _getInicidenceData() {
    _globalIncidence = globalIncidenceProvider.getGlobalIncidence(_initialDate, _finalDate);
  }

  Widget _getDates(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      height: (_screenSize.height - (kToolbarHeight + kTextTabBarHeight)) * 0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: _screenSize.width / 2,
            child: MyDatePicker(
              label: Constants.LABEL_INITIAL_DATE, 
              hint: Constants.HINT_INITIAL_DATE, 
              currentValue: _initialDate,
              callbackFn: onInitialDateChanged
            )
          ),
          Container(
            alignment: Alignment.center,
            width: _screenSize.width / 2,
            child: MyDatePicker(
              label: Constants.LABEL_FINAL_DATE, 
              hint: Constants.HINT_FINAL_DATE,
              currentValue: _finalDate, 
              callbackFn: onFinalDateChanged
            )
          )
        ]
      )
    );
  }

  Widget _getGlobalChart(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      height: (_screenSize.height - (kToolbarHeight + kTextTabBarHeight)) * 0.8,
      child: FutureBuilder(
        future: _globalIncidence,
        builder: (BuildContext context, AsyncSnapshot<GlobalIncidences> snapshot) {
          if (snapshot.hasData) {
            var chartSeries = _defineChartSeries(snapshot.data);
            return _defineGlobalChart(chartSeries);
          }
          else if (snapshot.hasError) {
            return _displayNoDataAvailable(_screenSize);
          }
          return _displayLoading(_screenSize);
        }
      )
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

  Widget _displayLoading(Size screenSize) {
    return Container(
      height: screenSize.height * 0.5,
      child: Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Widget _displayNoDataAvailable(Size screenSize) {
    return Container(
      height: screenSize.height * 0.5,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sentiment_dissatisfied, color: Colors.white, size: 40.0,),
            SizedBox(width: 10.0),
            Text('No data available during these days.', style: TextStyle(color: Colors.white, fontSize: 15.0))
          ],
        ),
      )
    );
  }
}