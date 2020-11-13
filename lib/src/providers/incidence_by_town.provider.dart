
import 'package:flutter_covid_app/src/models/incidences_by_town.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class IncidenceByTownProvider {
  String _apiKey = 'nNoXhDJ82fT90BsS-BWkkRAXORSqFbYpEWAB';
  //String _urlBase = 'analisi.transparenciacatalunya.cat/resource/623z-r97q.json';
  
  Future<IncidencesByTown> getIncidenceByTown(String municipiCode) async {
    String params = "\$where=data >= '2020-04-01T00:00:00.000' AND data <= '2020-04-05T00:00:00.000'&municipicodi=$municipiCode";
    final url = 'https://analisi.transparenciacatalunya.cat/resource/jj6z-iyrp.json?$params';

    final response = await http.get(url, headers: {
      'x-api-key': _apiKey
    });
    final decodedData = json.decode(response.body);
    final incidences = new IncidencesByTown.fromJsonList(decodedData);
    
    return incidences;
  }
}