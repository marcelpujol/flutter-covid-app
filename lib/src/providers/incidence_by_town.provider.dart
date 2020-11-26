
import 'package:flutter_covid_app/src/models/incidences_by_town.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class IncidenceByTownProvider {
  String _apiKey = 'nNoXhDJ82fT90BsS-BWkkRAXORSqFbYpEWAB';
  
  Future<IncidencesByTown> getIncidenceByTown(String municipiCode, String initialDate, String finalDate) async {
    if (_areValidDates(DateTime.parse(initialDate), DateTime.parse(finalDate))) {
      String params = "\$where=data >= '$initialDate' AND data <= '$finalDate'&municipicodi=$municipiCode";
      final url = 'https://analisi.transparenciacatalunya.cat/resource/jj6z-iyrp.json?$params';

      final response = await http.get(url, headers: {
        'x-api-key': _apiKey
      });
      final decodedData = json.decode(response.body);
      final incidences = new IncidencesByTown.fromJsonList(decodedData);
      
      return incidences;
    }
    throw('Invalid dates');
  }

  bool _areValidDates(DateTime initialDate, DateTime finalDate) {
    return initialDate.isBefore(finalDate) || initialDate.isAtSameMomentAs(finalDate);
  }
}