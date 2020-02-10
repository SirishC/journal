import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
              "My Home",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
