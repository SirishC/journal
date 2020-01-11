import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _dateTime == null
                ? formatDate(DateTime.now(), [M, ',', dd, ',', yyyy])
                : formatDate(_dateTime, [M, ',', dd, ',', yyyy]),
            style: TextStyle(fontSize: 25),
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.calendar_today),
              color: Colors.black,
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2200))
                    .then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
              }),
        ],
      ),
    );
  }
}
