import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_covid_app/src/pages/global_page.dart';
import 'package:flutter_covid_app/src/pages/towns_list_page.dart';
import './src/constants/constants.dart' as Constants;
 
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
      darkTheme: ThemeData.dark(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(25, 27, 37, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(45, 47, 57, 1.0),
            elevation: 0,
            bottom: _getTabs(), 
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.coronavirus),
                SizedBox(width: 10),
                Text(Constants.APP_NAME)
              ],
            )
          ),
          body: Builder(
            builder: (context) => 
              TabBarView(
                children: [
                  GlobalPage(globalContext: context),
                  TownsListPage(),
                  GlobalPage(globalContext: context)
                ],
              )
          )
        )
      )
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