import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/preventions_info.dart';
import 'package:flutter_covid_app/src/providers/prevention_info.provider.dart';
import 'package:flutter_covid_app/src/widgets/my-list-view.widget.dart';

class PreventionInfoListPage extends StatelessWidget {
  final PreventionInfoProvider preventionInfoProvider = new PreventionInfoProvider();
  
  @override
  Widget build(BuildContext context) {
    Future<PreventionsInfo> _preventionsInfoData = preventionInfoProvider.getPreventionsList();
    var _screenSize = MediaQuery.of(context).size;

    return Container(
      child: FutureBuilder(
        future: _preventionsInfoData,
        builder: (BuildContext context, AsyncSnapshot<PreventionsInfo> snapshot) {
          if (snapshot.hasData) {
            return MyListViewWidget(items: snapshot.data);
          }
          return _displayLoading(_screenSize);
        }
      )
    );
  }

  Widget _displayLoading(Size screenSize) {
    return Container(
      height: screenSize.height * 0.5,
      child: Center(
        child: CircularProgressIndicator()
      )
    );
  }
}