
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_covid_app/src/models/global_incidence.dart';

class GlobalIncidenceProvider {
  String _apiKey = 'nNoXhDJ82fT90BsS-BWkkRAXORSqFbYpEWAB';
  //String _urlBase = 'analisi.transparenciacatalunya.cat/resource/623z-r97q.json';

  Future<GlobalIncidence> getGlobalIncidence() async {
    String params = 'data=2020-02-24T00:00:00.000';
    final url = 'https://analisi.transparenciacatalunya.cat/resource/623z-r97q.json?$params';

    final response = await http.get(url, headers: {
      'x-api-key': _apiKey
    });
    final decodedData = json.decode(response.body);
    final globalIncidence = new GlobalIncidence.fromJsonMap(decodedData);
    
    return globalIncidence;
  }
}