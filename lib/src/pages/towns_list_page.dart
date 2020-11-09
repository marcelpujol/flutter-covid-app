import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/towns.dart';
import 'package:flutter_covid_app/src/providers/town_list.provider.dart';

class TownsListPage extends StatelessWidget {
  final townListProvider = new TownListProvider();

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  Widget _getTownsList() {
    return FutureBuilder(
      future: townListProvider.getTownList(),
      builder: (BuildContext context, AsyncSnapshot<Towns> snapshot) {
        if (snapshot.hasData) {
          return _renderList(snapshot.data);
        }
        else {
          //TODO: do a loading
        }
      } 
    );
  }

  Widget _renderList(Towns towns) {
    return ListView.separated(
      itemBuilder: null, 
      separatorBuilder: null, 
      itemCount: null);
  }
}