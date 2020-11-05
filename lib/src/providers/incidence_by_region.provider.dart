
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_covid_app/src/models/incidences_by_region.dart';

class IncidenceByRegionProvider {
  //String _apiKey = 'nNoXhDJ82fT90BsS-BWkkRAXORSqFbYpEWAB';
  //String _urlBase = 'analisi.transparenciacatalunya.cat/resource/623z-r97q.json';
  
  Future<IncidencesByRegion> getIncidenceByRegion() async {
    String params = 'codi=13';
    final url = 'https://analisi.transparenciacatalunya.cat/resource/c7sd-zy9j.json?${params}';

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final incidences = new IncidencesByRegion.fromJsonList(decodedData);
    
    return incidences;
  }
}