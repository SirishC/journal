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
  bool _isVisible = false;
  String dropdownValue = 'Emotion';


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                    actionExtentRatio: 0.25,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        child: TextField(
                          onChanged: (_) {
                            setState(() {
                              _isVisible = true;
                            });
                          },
                          controller: feedData[index],
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
//                              print("Starting Index : ${feedData[index].selection.baseOffset}" );
//                              print("Ending Index : ${feedData[index].selection.extentOffset}" );
                              _splitFeeds(index);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: feedData.length,
//              childCount: 0,
            ),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          child: Icon(
            Icons.done,
            color: Colors.black,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            setState(() {
              _isVisible = false;
            });
          },
        ),
      ),
    );
  }


  _onAlertWithCustomContentPressed(context) {
    TextEditingController tagController_type = new TextEditingController();
    TextEditingController tagController_name = new TextEditingController();
    String tagSelect = null;

    Alert(
        context: context,
        title: "ADD TAGS",
        content: Column(
          children: <Widget>[
//            TextField(
//              controller: tagController_type,
//              decoration: InputDecoration(
//                icon: Icon(Icons.tag_faces),
//                labelText: 'TAG TYPE',
//              ),
//            ),

            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                dropdownValue = newValue;
//            setState(() {
//              dropdownValue = newValue;
//            });
              },
              items: <String>['Emotion', 'Person', 'Custom']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
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

_splitFeeds(index) {
  List<TextEditingController> temp = [];
  for (int i = 0; i < index; i++) {
    temp.add(feedData[i]);
  }
  if (feedData[index].selection.extentOffset -
      feedData[index].selection.baseOffset != 0) {

    if (feedData[index].selection.baseOffset != 0) {
      temp.add(TextEditingController(text: feedData[index].text.substring(
          0, feedData[index].selection.baseOffset).trim()));
    }

    temp.add(TextEditingController(text: feedData[index].text.substring(
        feedData[index].selection.baseOffset,
        feedData[index].selection.extentOffset).trim()));

    if (feedData[index].selection.extentOffset != feedData[index].text.length) {
      temp.add(TextEditingController(text: feedData[index].text.substring(
          feedData[index].selection.extentOffset, feedData[index].text.length)
          .trim()));
    }
  } else {
    temp.add(feedData[index]);
  }
  for (int i = index + 1; i < feedData.length; i++) {
    temp.add(feedData[i]);
  }
  feedData = temp;
}
