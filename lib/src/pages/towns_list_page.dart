import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_covid_app/src/models/town.dart';
import 'package:flutter_covid_app/src/models/towns.dart';
import 'package:flutter_covid_app/src/providers/town_list.provider.dart';

class TownsListPage extends StatefulWidget {
  @override
  TownsListPageState createState() {
    return new TownsListPageState();
  }
}

class TownsListPageState extends State<TownsListPage> {
  final townListProvider = new TownListProvider();
  Timer _debounce;
  Future<Towns> _towns;

  @override
  void initState() {
      super.initState();
      _towns = townListProvider.getTownList('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _getSearch(context)
          ),
          Expanded(
            flex: 9,
            child: _getTownsList(context, null)
          )
        ],
      )
    );
  }

  Widget _getSearch(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white60,),
          hintText: 'Search a town here...',
          hintStyle: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.w300
          )
        ),
        onChanged: (String searchTerm)  {
         _onSearchChanged(context, searchTerm);
        },
      )
    );
  }

  _onSearchChanged(BuildContext context, String searchTerm) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          _towns = townListProvider.getTownList(searchTerm);
        });
      });
  }

  Widget _getTownsList(BuildContext context, String searchTerm) {
    var _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _towns,
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
    final _townCardItem = Card(
      color: Color.fromRGBO(35, 37, 47, 1.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            AutoSizeText(town.name,
              wrapWords: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w300, 
                fontSize: 16
              )
            )
          ]
        ),
      )
    );

    return GestureDetector(
      child: _townCardItem,
      onTap: ()  {
        (Navigator.pushNamed(context, 'town-page', arguments: town));
      }
    );
  }
}