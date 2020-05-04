import 'dart:math';

import 'package:flutter/material.dart';
import 'package:journal/data/data.dart';
import 'package:journal/pages/bargraph.dart';
import 'package:journal/pages/piegraph.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<EmotionCount> emotionList = [
  ];

  void initState() {
    super.initState();
    _AddEmotions();
  }

  // Bar Graph data
  List<charts.Series<OrdinalUser, String>> _userData() {
    final data = [
      new OrdinalUser('Sirish', 24),
      new OrdinalUser('Preethi', 16),
      new OrdinalUser('Murali', 10),
      new OrdinalUser('PK', 5),
      new OrdinalUser("Gowtham", 1)
    ];

    return [
      new charts.Series<OrdinalUser, String>(
        id: 'user',
        colorFn: (_, __) =>
        charts.MaterialPalette.deepOrange.shadeDefault.lighter,
        domainFn: (OrdinalUser user, _) => user.name,
        measureFn: (OrdinalUser user, _) => user.count,
        data: data,
      )
    ];
  }

  // Pie Graph data
  List<charts.Series<EmotionCount, String>> _emotionData() {
    final data = emotionList;


    return [
      new charts.Series<EmotionCount, String>(
        id: 'EmotionCount',

        domainFn: (EmotionCount emotion, _) => emotion.Emotion,
        measureFn: (EmotionCount emotion, _) => emotion.count,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (EmotionCount row, _) => '${row.Emotion}: ${row
            .count}',
      )
    ];
  }


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

          title: Text("Statistics",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Container(
                height: 100,
              ),
              Center(
                child: Text(
                  "Instance of Anger",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              Container(
                height: 100,
              ),
//            Container(
//              margin: EdgeInsets.symmetric(horizontal: 15),
//              decoration: new BoxDecoration(
//                color: Colors.white,
//                boxShadow: [
//                  new BoxShadow(
//                    color: Colors.black54,
//                    blurRadius: 3.0,
//                  ),
//                ],
//                borderRadius: new BorderRadius.circular(20),
//              ),
//              padding: EdgeInsets.all(5),
//              child: SizedBox(
//                height: 300.0,
//                child: SimpleBarChart(_userData()),
//              ),
//            ),
              Padding(
                padding: EdgeInsets.all(32),
                child: SizedBox(
                  height: 300.0,
                  child: SimpleBarChart(_userData()),
                ),
              ),
              Container(
                height: 100,
              ),
              Center(
                child: Text(
                  "Overall Emotion",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: SizedBox(
                  height: 300.0,
                  child: PieOutsideLabelChart(_emotionData()),
                ),
              ),


            ],
          ),
        )

    );
  }

  _AddEmotions() {
    emotionList = [];
    if (overallData.emotionTags.length != 0)
      for (String tag in overallData.emotionTags) {
        int pos = _isContains(tag);
        if (pos != -1) {
          emotionList[pos].count++;
        }
        else {
          emotionList.add(EmotionCount(tag, 1));
        }
      }
    else
      emotionList.add(EmotionCount("NoEmotions", 1));
  }

  _isContains(tag) {
    for (int i = 0; i < emotionList.length; i++) {
      if (emotionList[i].count == tag) {
        return i;
      }
    }
    return -1;
  }
}
// Class for Bar Graph.
class OrdinalUser {
  final String name;
  final int count;

  OrdinalUser(this.name, this.count);
}
// Class for Pie Graph.
//class EmotionCount {
//  final String Emotion;
//   int count;
//  EmotionCount(this.Emotion, this.count);
//}