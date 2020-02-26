import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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

        title: Text(
          "Search",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
        actions: <Widget>[
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Row(
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}
