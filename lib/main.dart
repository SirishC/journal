import 'package:flutter/material.dart';

import 'package:journal/body.dart';
import 'package:journal/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          accentColor: Color(0xffFF7582),
          primaryColor: Color(0xffFF7582)),
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}
