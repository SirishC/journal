import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journal/body.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(EvaIcons.menu2Outline,
            color: Color(0xffFF7582),),
          iconSize: 35,
          onPressed: () {},
        ),

        title: Text(formatDate(
            _dateTime == null
                ? DateTime
                .now() //formatDate(DateTime.now(), [M, ',', dd, ',', yyyy])
                : _dateTime,
            [dd, ',', M, ',', yyyy]),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
        actions: <Widget>[
          IconButton(
              icon: Icon(EvaIcons.calendarOutline),

              iconSize: 25,
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.15,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text('Feed'),
                        subtitle: Text('Feed card number ' + index.toString()),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Add',
                        color: Colors.blue,
                        icon: Icons.add_box,
                        onTap: () =>
                            () {
                          print("Adding Tags.");
                        },
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),

          )
        ],
      ),


    );
  }
}

/*






 */
