import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/town.dart';
import 'package:flutter_covid_app/src/models/towns.dart';
import 'package:flutter_covid_app/src/providers/town_list.provider.dart';

class TownsListPage extends StatelessWidget {
  final townListProvider = new TownListProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: _getTownsList(context)
    );
  }


  Widget _getTownsList(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: townListProvider.getTownList(),
      builder: (BuildContext context, AsyncSnapshot<Towns> snapshot) {
        if (snapshot.hasData) {
          return _renderList(snapshot.data);
        }
        return Container(
          height: _screenSize.height * 0.5,
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      } 
    );
  }

  Widget _renderList(Towns towns) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(towns.data.length, (index) {
        return _renderTownItemList(towns.data[index]);
      }),
    );
  }

  Widget _renderTownItemList(Town town) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInImage(
            height: 80,
            placeholder: AssetImage('assets/img/default-image.png'), 
            image: NetworkImage(town.logo),
            fit: BoxFit.cover
          ),
          SizedBox(height: 10),
          Text(town.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.w600, 
              fontSize: 20
            )
          )
        ]
      )
    );
  }
}