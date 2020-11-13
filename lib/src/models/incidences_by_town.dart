import 'package:flutter_covid_app/src/models/incidence_by_town.dart';

class IncidencesByTown {
  List<IncidenceByTown> data = new List();

  IncidencesByTown();

  IncidencesByTown.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final incidenceByRegion = new IncidenceByTown.fromJsonMap(item);
      data.add(incidenceByRegion);
    }
  }
}