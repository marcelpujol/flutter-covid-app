import 'package:flutter_covid_app/src/models/global_incidence.dart';

class GlobalIncidences {
  List<GlobalIncidence> globalIncidences = new List();

  GlobalIncidences();

  GlobalIncidences.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final globalIncidence = new GlobalIncidence.fromJsonMap(item);
      globalIncidences.add(globalIncidence);
    }
  }
}