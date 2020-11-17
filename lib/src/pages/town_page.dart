import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/incidence_by_town.dart';
import 'package:flutter_covid_app/src/models/incidences_by_town.dart';

import 'package:flutter_covid_app/src/models/town.dart';
import 'package:flutter_covid_app/src/providers/incidence_by_town.provider.dart';
import 'package:flutter_covid_app/src/widgets/my_pie_chart.widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_covid_app/src/constants/constants.dart' as Constants;

class TownPage extends StatelessWidget {
  final incidenceByTownProvider = new IncidenceByTownProvider();
  
  @override
  Widget build(BuildContext context) {
    final Town town = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 27, 37, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(45, 47, 57, 1.0),
        title: Text(town.name),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 20.0, right: 20.0, bottom: 0),
        child: _getTownChart(context, town),
      )
    );
  }

  Widget _getTownChart(BuildContext context, Town town) {
    var _screenSize = MediaQuery.of(context).size;
    
    return FutureBuilder(
      future: incidenceByTownProvider.getIncidenceByTown(town.code),
      builder: (BuildContext context, AsyncSnapshot<IncidencesByTown> snapshot) {
        if (snapshot.hasData) {
          var chartSegments = _defineChartSegments(snapshot.data);
          return _defineTownChart(chartSegments, context);
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
            flex: 6,
            child: MyPieChart.createChart(segments)
          ),
          Expanded(
            flex: 4,
            child: MyPieChart.getLegend(segments, context)
          )
        ]
      )
    );
  }
}