import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
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
              "Statistics",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
