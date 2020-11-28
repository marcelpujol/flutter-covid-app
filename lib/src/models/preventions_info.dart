import 'package:flutter_covid_app/src/models/prevention_info.dart';

class PreventionsInfo {
  List<PreventionInfo> data = new List<PreventionInfo>();

  PreventionsInfo();

  PreventionsInfo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.length == 0) return;
    for (var item in jsonList) {
      PreventionInfo preventionInfo = PreventionInfo.fromJsonMap(item);
      data.add(preventionInfo);
    }
  }
}