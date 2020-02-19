import 'package:flutter/material.dart';
import 'package:journal/pages/bargraph.dart';
import 'package:journal/pages/piegraph.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

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
    final data = [
      new EmotionCount("anger", 21),
      new EmotionCount("sad", 28),
      new EmotionCount("disgusted", 7),
      new EmotionCount("fearful", 10),
      new EmotionCount("bad", 3),
      new EmotionCount("happy", 17),

    ];

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
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
}

// Class for Bar Graph.
class OrdinalUser {
  final String name;
  final int count;

  OrdinalUser(this.name, this.count);
}
// Class for Pie Graph.
class EmotionCount {
  final String Emotion;
  final int count;

  EmotionCount(this.Emotion, this.count);
}