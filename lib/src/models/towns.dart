import 'package:flutter_covid_app/src/models/global_incidence.dart';
import 'package:flutter_covid_app/src/models/town.dart';

class Towns {
  List<Town> data = new List();

  Towns();

  Towns.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final town = new Town.fromJsonMap(item);
      data.add(town);
    }
  }
}