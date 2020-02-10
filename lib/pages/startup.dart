import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/menu.png'),
              iconSize: 50,
              onPressed: () {},
            ),
            Text(
              formatDate(
                  _dateTime == null
                      ? DateTime
                          .now() //formatDate(DateTime.now(), [M, ',', dd, ',', yyyy])
                      : _dateTime,
                  [dd, ',', M, ',', yyyy]),
              //formatDate(_dateTime, [M, ',', dd, ',', yyyy]),
              style: TextStyle(fontSize: 40),
            ),
            IconButton(
                icon: Icon(EvaIcons.calendar),
                iconSize: 35,
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              _dateTime == null ? DateTime.now() : _dateTime,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((date) {
                    setState(() {
                      _dateTime = date;
//                      _date = _dateTime.day * 1000000 + _dateTime.month *
//                          10000 + _dateTime.year;
                    });
                  });
                }),
          ],
        ),
      ),
    );
  }
}

/*






 */
