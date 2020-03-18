import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journal/data/data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StartUp extends StatefulWidget {
  StartUp({
    Key key,
  }) :super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  DateTime _dateTime = DateTime.now();
  double _slide = 0.25;
  TextEditingController eventController = new TextEditingController();

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            EvaIcons.menu2Outline,
            color: Color(0xffFF7582),
          ),
          iconSize: 35,
          onPressed: () {},
        ),
        title: Text(
          formatDate(
              _dateTime == null
                  ? DateTime
                  .now() //formatDate(DateTime.now(), [M, ',', dd, ',', yyyy])
                  : _dateTime,
              [dd, ',', M, ',', yyyy]),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
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
                    eventController.text =
                        data.getEvent(formatDate(_dateTime, [dd, mm, yyyy]));
//                      _date = _dateTime.day * 1000000 + _dateTime.month *
//                          10000 + _dateTime.year;
                  });
                });
              }),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {
            data.add(
                formatDate(_dateTime, [dd, mm, yyyy]), eventController.text);
            print("added filed");
          });
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Container(
                          child: TextField(
                            controller: eventController,
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter how your day went.",
                            ),
                          ),
                        ),

                      ),
                      secondaryActions: <Widget>[
                        GestureDetector(
                          child: IconSlideAction(
                            caption: 'Add Tags',
                            color: Color(0xffFF7582),
                            icon: EvaIcons.pricetags,
                            onTap: () {
                              setState(() {
                                _onAlertWithCustomContentPressed(context);
                              });
                            },

                          ),
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
      ),
    );
  }


  _onAlertWithCustomContentPressed(context) {
    TextEditingController tagController_type = new TextEditingController();
    TextEditingController tagController_name = new TextEditingController();
    Alert(
        context: context,
        title: "ADD TAGS",
        content: Column(
          children: <Widget>[
            TextField(
              controller: tagController_type,
              decoration: InputDecoration(
                icon: Icon(Icons.tag_faces),
                labelText: 'TAG TYPE',
              ),
            ),
            TextField(
              controller: tagController_name,
              decoration: InputDecoration(
                icon: Icon(EvaIcons.pricetags),
                labelText: 'TAG NAME',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                print(
                    tagController_type.text + " : " + tagController_name.text);
              });
              Navigator.pop(context);
            },
            child: Text(
              "ADD TAG",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}

/*






 */