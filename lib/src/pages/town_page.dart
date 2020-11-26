import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/incidence_by_town.dart';
import 'package:flutter_covid_app/src/models/incidences_by_town.dart';

import 'package:flutter_covid_app/src/models/town.dart';
import 'package:flutter_covid_app/src/providers/incidence_by_town.provider.dart';
import 'package:flutter_covid_app/src/widgets/my_date_picker.widget.dart';
import 'package:flutter_covid_app/src/widgets/my_pie_chart.widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_covid_app/src/constants/constants.dart' as Constants;

class TownPage extends StatefulWidget {
  final Town town;
  TownPage({ @required this.town});

  TownPageState createState() {
    return new TownPageState();
  }
}
class TownPageState extends State<TownPage> {
  final incidenceByTownProvider = new IncidenceByTownProvider();
  Future<IncidencesByTown> _incidencesByTown;
  String _initialDate = '2020-04-01';
  String _finalDate = '2020-04-07';
  
  @override
  void initState() {
    super.initState();
    _getIncidenceData();
  }

  onInitialDateChanged(String initialDate) {
    setState(() {
      _initialDate = initialDate;
      _getIncidenceData();
    });
  }

  onFinalDateChanged(String finalDate) {
    setState(() {
      _finalDate = finalDate;
      _getIncidenceData();
    });
  }

  void _getIncidenceData() {
    _incidencesByTown = incidenceByTownProvider.getIncidenceByTown(widget.town.code, _initialDate, _finalDate);
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 27, 37, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(45, 47, 57, 1.0),
        title: Text(widget.town.name),
      ),
      body: Container(
        child: Column(
          children: [
            _getDates(context),
            _getTownChart(context, widget.town)
          ],
        )
      )
    );
  }

  Widget _getDates(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
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

  Widget _getTownChart(BuildContext context, Town town) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      height: (_screenSize.height - kToolbarHeight) * 0.8,
      child: FutureBuilder(
        future: _incidencesByTown,
        builder: (BuildContext context, AsyncSnapshot<IncidencesByTown> snapshot) {
          if (snapshot.hasData) {
            var chartSegments = _defineChartSegments(snapshot.data);
            return _defineTownChart(chartSegments, context);
          }
          else if (snapshot.hasError) {
            return _displayNoDataAvailable(_screenSize);
          }
          else return _displayLoading(_screenSize);
        }
      )
    );
  }

  List<PieChartSegment> _defineChartSegments(IncidencesByTown incidencesByTown) {
    List<PieChartSegment> allSegments = new List<PieChartSegment>();
    PieChartSegment positivePcrCases = new PieChartSegment('Positive PCR', 0, charts.MaterialPalette.red.shadeDefault);
    PieChartSegment positiveFastTestCases = new PieChartSegment('Positive Fast Test', 0, charts.MaterialPalette.purple.shadeDefault);
    PieChartSegment positiveElisaCases = new PieChartSegment('Positive ELISA', 0, charts.MaterialPalette.blue.shadeDefault);
    PieChartSegment suspiciousCases = new PieChartSegment('Suspicious', 0, charts.MaterialPalette.green.shadeDefault);

    for (IncidenceByTown incidenceByTown in incidencesByTown.data) {
      switch(incidenceByTown.testCovidResult) {
        case Constants.POSITIVE_PCR_CASE:
          positivePcrCases.size += incidenceByTown.totalCases;
          break;
        case Constants.POSITIVE_FAST_TEST_CASE:
          positiveFastTestCases.size += incidenceByTown.totalCases;
          break;
        case Constants.POSITIVE_ELISA_CASE:
          positiveElisaCases.size += incidenceByTown.totalCases;
          break;
        case Constants.SUSPICIOUS_CASE:
          suspiciousCases.size += incidenceByTown.totalCases;
          break;
      }
    }

    allSegments.add(positivePcrCases);
    allSegments.add(positiveFastTestCases);
    allSegments.add(positiveElisaCases);
    allSegments.add(suspiciousCases);
    return allSegments;
  }

  Widget _defineTownChart(List<PieChartSegment> segments, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: MyPieChart.createChart(segments)
          ),
          Expanded(
            flex: 3,
            child: MyPieChart.getLegend(segments, context)
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