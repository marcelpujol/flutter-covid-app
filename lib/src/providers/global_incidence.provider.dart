
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_covid_app/src/models/global_incidences.dart';

class GlobalIncidenceProvider {
  String _apiKey = 'nNoXhDJ82fT90BsS-BWkkRAXORSqFbYpEWAB';

  Future<GlobalIncidences> getGlobalIncidence(String initialDate, String finalDate) async {
    if (_areValidDates(DateTime.parse(initialDate), DateTime.parse(finalDate))) {
      String params = "\$where=data >= '${initialDate}T00:00:00.000' AND data <= '${finalDate}T00:00:00.000'";
      final url = 'https://analisi.transparenciacatalunya.cat/resource/623z-r97q.json?$params';

      final response = await http.get(url, headers: {
        'x-api-key': _apiKey
      });
      final decodedData = json.decode(response.body);
      final globalIncidences = new GlobalIncidences.fromJsonList(decodedData);
      
      return globalIncidences;
    }
    throw('Invalid dates');
  }

  bool _areValidDates(DateTime initialDate, DateTime finalDate) {
    return initialDate.isBefore(finalDate) || initialDate.isAtSameMomentAs(finalDate);
  }
}