import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/pages/global_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAT-COVID',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => GlobalPage()
      }
    );
  }
}