import 'package:flutter_covid_app/src/models/incidence_by_region.dart';

class IncidencesByRegion {
  List<IncidenceByRegion> incidencesByRegion = new List();

  IncidencesByRegion();

  IncidencesByRegion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final incidenceByRegion = new IncidenceByRegion.fromJsonMap(item);
      incidencesByRegion.add(incidenceByRegion);
    }
  }
}