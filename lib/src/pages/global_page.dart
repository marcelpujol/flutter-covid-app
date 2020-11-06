import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_covid_app/src/providers/global_incidence.provider.dart';
import 'package:flutter_covid_app/src/providers/incidence_by_region.provider.dart';
import 'package:flutter_covid_app/src/providers/incidence_by_town.provider.dart';

class GlobalPage extends StatelessWidget {
  final incidenceByRegionProvider = new IncidenceByRegionProvider();
  final globalIncidenceProvider = new GlobalIncidenceProvider();
  final incidenceByTownProvider = new IncidenceByTownProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAT-COVID')
      ),
      body: Container(
        child: Column(
          children: [
            OutlineButton(
              onPressed: () => {
                incidenceByRegionProvider.getIncidenceByRegion()
                .then((value) {
                  print(value.toString());
                })
              },
              child: Text('By region call')
            ),
            OutlineButton(
              onPressed: () => {
                globalIncidenceProvider.getGlobalIncidence()
                .then((value) {
                  print(value.toString());
                })
              },
              child: Text('Global call')
            ),
            OutlineButton(
              onPressed: () => {
                incidenceByTownProvider.getIncidenceByTown()
                .then((value) {
                  print(value.toString());
                })
              },
              child: Text('By town call')
            )
          ]
        )
      ),
    );

    // incidenceByRegionProvider.getIncidenceByRegion()
    // .then((value) => {
    //   print('byRegion: ' + value.toString())
    // });

    // globalIncidenceProvider.getGlobalIncidence()
    // .then((value) => {
    //   print('global: ' + value.toString())
    // });

    // incidenceByTownProvider.getIncidenceByTown()
    // .then((value) => {
    //   print('byTown: ' + value.toString())
    // });

    return Text('Hola');
  }
}