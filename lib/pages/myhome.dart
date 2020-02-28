import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(EvaIcons.menu2Outline,
              color: Color(0xffFF7582),),
            iconSize: 35,
            onPressed: () {},
          ),

          title: Text("My Home",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
        ),
        body: new Calendar(
          // A builder function that renders each calendar tile how you'd like.
          //isExpandable: true,
          //dayBuilder: (BuildContext context, DateTime day) {
          //return new Text("!");
          //},
        )

    );
  }
}