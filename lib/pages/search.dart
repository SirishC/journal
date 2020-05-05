//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:journal/utils/autocomplete.dart';
import 'package:journal/utils/searchview.dart';
import '../data/data.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _selectedText ;
  bool _st = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: _st
            ?
        Text("Search Events",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),)
            : AutoComplete(),
        leading: IconButton(
          icon: Icon(EvaIcons.menu2Outline,
            color: Color(0xffFF7582),),
          iconSize: 35,
          onPressed: () {},
        ),
        actions: <Widget>[
          _st ?
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _st = false;
                  });
//                  print()
                },
                child: Icon(Icons.search, size: 30.0,),
              )
            //child: Icon(Icons.search,size:26.0,),
          )
              :
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _st = true;
                  });
                  print("hii");
                },
                child: Icon(Icons.close, size: 30.0,),
              )
            //child: Icon(Icons.search,size:26.0,),
          ),
        ],
      ),
      body: SearchView(),
    );
  }
}
