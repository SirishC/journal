import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _dateTime = DateTime.now();
  bool _read = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xff4a6572),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(EvaIcons.calendar),
                  color: Color(0xffF9AA33),
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
                      });
                    });
                  }),
            ],
            pinned: true,
            backgroundColor: Color(0xff232f34),
            floating: true,
            expandedHeight: 200,
            flexibleSpace: Row(
              children: <Widget>[
                Container(
                  width: 300,
                  child: FlexibleSpaceBar(
                    title: Text(
                      formatDate(_dateTime == null
                          ? DateTime
                          .now() //formatDate(DateTime.now(), [M, ',', dd, ',', yyyy])
                          : _dateTime, [M, ',', dd, ',', yyyy]),
                      //formatDate(_dateTime, [M, ',', dd, ',', yyyy]),
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Container(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3.0,
                          ),
                        ],
                        borderRadius: new BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            _read = false;
                          });
                        },
                        child: TextField(
                          maxLines: 99,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                          ),
                          onTap: () {
                            setState(() {
                              _read = true;
                            });
                          },
                          readOnly: _read,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
