
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_covid_app/src/models/towns.dart';

class TownListProvider {

  Future<Towns> getTownList() async {
    final response = await rootBundle.loadString('assets/municipis.json');
    final decodedData = json.decode(response);
    final towns = new Towns.fromJsonList(decodedData);
    
    return towns;
  }

}