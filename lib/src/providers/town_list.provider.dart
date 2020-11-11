
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_covid_app/src/models/town.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_covid_app/src/models/towns.dart';

class TownListProvider {

  Future<Towns> getTownList(String searchTerm) async {
    final response = await rootBundle.loadString('assets/municipis.json');
    final decodedData = json.decode(response);
    final towns = new Towns.fromJsonList(decodedData);
    
    if (searchTerm == null || searchTerm == '') return towns;
    else {
      List<Town> _filteredTowns = List<Town>();
      _filteredTowns = towns.data.where((town) {
        return (town.name.toLowerCase().contains(searchTerm.toLowerCase()));
      }).toList();
      towns.data = _filteredTowns;
    }

    return towns;
  }

}