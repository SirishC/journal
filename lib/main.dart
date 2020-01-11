import 'package:flutter/material.dart';
import 'package:journal/home.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Introspective Journal",
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Welcome, Sirish C',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
              color: Colors.black,
            ),
          ],
        ),
        body: Home(),
        bottomNavigationBar: BottomAppBar(
          elevation: 10.0,
          child: Container(
            color: Colors.white,
            height: 80.0,
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.dehaze,
                  ),
                  color: Colors.black,
                  iconSize: 30,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_to_photos,
                  ),
                  color: Colors.black,
                  iconSize: 30,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.pie_chart,
                  ),
                  color: Colors.black,
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
