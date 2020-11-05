import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/providers/global_incidence.provider.dart';
import 'package:flutter_covid_app/src/providers/incidence_by_region.provider.dart';

class GlobalPage extends StatelessWidget {
  final incidenceByRegionProvider = new IncidenceByRegionProvider();
  final globalIncidenceProvider = new GlobalIncidenceProvider();

  @override
  Widget build(BuildContext context) {
    incidenceByRegionProvider.getIncidenceByRegion()
    .then((value) => {
      print(value)
    });

    globalIncidenceProvider.getGlobalIncidence()
    .then((value) => {
      print(value)
    });

    return Text('Hola');
  }
}