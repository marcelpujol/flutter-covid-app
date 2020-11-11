import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_covid_app/src/pages/global_page.dart';
import 'package:flutter_covid_app/src/pages/town_page.dart';
import 'package:flutter_covid_app/src/pages/towns_list_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: _getTabs(), 
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.coronavirus),
                SizedBox(width: 10),
                Text('CAT-COVID')
              ],
            )
          ),
          body: TabBarView(
            children: [
              GlobalPage(),
              TownsListPage(),
              GlobalPage(),
            ],
          ),
        )
      ),
      routes: {
        'town-page': (context) => TownPage()
      },
    );
  }
}

Widget _getTabs() {
  return TabBar(
    tabs: [
      Tab(icon: Icon(Icons.bar_chart)),
      Tab(icon: Icon(Icons.location_city)),
      Tab(icon: Icon(Icons.info))
    ]
  );
}