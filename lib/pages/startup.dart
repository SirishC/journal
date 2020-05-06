import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journal/data/data.dart';
import 'package:journal/pages/addingtag.dart';

class StartUp extends StatefulWidget {
  StartUp({
    Key key,
  }) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> with AutomaticKeepAliveClientMixin {

  /// Date State
  DateTime _dateTime = DateTime.now();

  /// Text focus .
  bool _isVisible = false;

  ///  persistent when there is a Route.
  bool get wantKeepAlive => true;

  /// day wise feeds.
  int day;

  /// Page Storage.
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    day = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      /// AppBar
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
                    if (data.isContains(_dateTime)) {
                      day = data.getItemByDate(
                          formatDate(_dateTime, [M, ',', dd, ',', yyyy]));
                    }
                    else {
                      data.add(formatDate(_dateTime, [M, ',', dd, ',', yyyy]));
                      day = data.getItemByDate(
                          formatDate(_dateTime, [M, ',', dd, ',', yyyy]));
                    }
                  });
                });
              }),
        ],
      ),

      /// Body
      body: PageStorage(
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
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  child: TextField(
                                    onChanged: (_) {
                                      setState(() {
                                        _isVisible = true;
                                      });
                                    },
                                    controller: data.dailyFeeds[day]
                                        .feedData[index].feed,
                                    keyboardType: TextInputType.multiline,
                                    autofocus: true,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter how your day went.",
                                    ),
                                  ),
                                ),
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: List<Widget>.generate(
                                      data.dailyFeeds[day].feedData[index].tags
                                          .length, (int items) {
                                    return Chip(
                                      avatar: Container(
                                        child: data.dailyFeeds[day]
                                            .feedData[index].tags[items]

                                        ///
                                            .type == "Emotion" ? Icon(
                                            Icons.insert_emoticon) :
                                        data.dailyFeeds[day].feedData[index]
                                            .tags[items].type ==

                                            ///
                                            "Person" ? Icon(Icons.person) :
                                        data.dailyFeeds[day].feedData[index]
                                            .tags[items].type ==

                                            ///
                                            "Place" ? Icon(Icons.pin_drop) :
                                        data.dailyFeeds[day].feedData[index]
                                            .tags[items].type ==

                                            ///
                                            "Custom"
                                            ? Icon(Icons.loyalty)
                                            : null,
                                      ),
                                      label: Text(
                                          data.dailyFeeds[day].feedData[index]
                                              .tags[items].name),
                                    );
                                  }),

                                ),

                              ],
                            )),
                      ),
                      secondaryActions: <Widget>[
                        GestureDetector(
                          child: IconSlideAction(
                            caption: 'Add Tags',
                            color: Color(0xffFF7582),
                            icon: EvaIcons.pricetags,
                            onTap: () {
//                            setState(() {
//                              _onAlertWithCustomContentPressed(index, );
//                            });
                              Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddingTag(day, index,
                                            data.dailyFeeds[day].feedData[index]
                                                .feed.selection
                                                .baseOffset,
                                            data.dailyFeeds[day].feedData[index]
                                                .feed.selection
                                                .extentOffset)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: data.dailyFeeds[day].feedData.length,
//              childCount: 0,
              ),
            )
          ],
        ),
        bucket: bucket,
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
}


