import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/menu.png'),
              iconSize: 50,
              onPressed: () {},
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
