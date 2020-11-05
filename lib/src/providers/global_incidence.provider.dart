
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_covid_app/src/models/global_incidence.dart';

class GlobalIncidenceProvider {
  //String _apiKey = 'nNoXhDJ82fT90BsS-BWkkRAXORSqFbYpEWAB';
  //String _urlBase = 'analisi.transparenciacatalunya.cat/resource/623z-r97q.json';

  Future<GlobalIncidence> getGlobalIncidence() async {
    String params = 'codi=13';
    final url = 'https://analisi.transparenciacatalunya.cat/resource/623z-r97q.json?${params}';

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final globalIncidence = new GlobalIncidence.fromJsonMap(decodedData);
    
    return globalIncidence;
  }
}