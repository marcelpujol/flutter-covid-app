import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_covid_app/src/models/preventions_info.dart';

class PreventionInfoProvider {
  Future<PreventionsInfo> getPreventionsList() async {
    final response = await rootBundle.loadString('assets/prevention.json');
    final decodedData = json.decode(response);
    PreventionsInfo preventionsInfo = PreventionsInfo.fromJsonList(decodedData);

    return preventionsInfo;
  }
}