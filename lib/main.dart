import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:journal/body.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';


void main() =>
    {
//  debugPaintLayerBordersEnabled =true,
      runApp(new MyApp()),
    };

class MyApp extends StatelessWidget {
  DateTime _date = null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Introspective Journal",
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff232f34),
          title: Text(
            'Welcome, Sirish C',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
              color: Color(0xffF9AA33),
            ),
          ],
        ),
        body: Body(),
        bottomNavigationBar: BottomAppBar(
          elevation: 10.0,
          child: Container(
            color: Color(0xffF9AA33),
            height: 80.0,
            padding: EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    print("blub 1 tapped !");
                  },
                  icon: Icon(
                    EvaIcons.bulbOutline,
                  ),
                  color: Colors.black,
                  iconSize: 30,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    print("wrong");
                  },
                  icon: Icon(
                    EvaIcons.plusSquareOutline,
                  ),
                  color: Colors.black,
                  iconSize: 30,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    print("Pie chart tapped !");
                  },
                  icon: Icon(
                    EvaIcons.pieChart,
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
