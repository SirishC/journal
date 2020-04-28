import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journal/data/data.dart';
import 'package:journal/pages/addingtag.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:journal/pages/tagselect.dart';
import 'package:journal/pages/selectedtags.dart';

class StartUp extends StatefulWidget {
  StartUp({
    Key key,
  }) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
//  final List<String> _list = [
//    '0',
//  ];
//  int _count = 0;
//  int _column = 0;
//  double _fontSize = 20;
  DateTime _dateTime = DateTime.now();
  bool _isVisible = false;
  String dropdownValue = 'Emotion';
//  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
//  List _items;

  @override
  void initState() {
    super.initState();
//    _items = _list.toList();
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
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                child: TextField(
                                  onChanged: (_) {
                                    setState(() {
                                      _isVisible = true;
                                    });
                                  },
                                  controller: feedData[index].feed,
                                  keyboardType: TextInputType.multiline,
                                  autofocus: true,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter how your day went.",
                                  ),
                                ),
                              ),
                              Text(" No of Tagged :${feedData[index].tags
                                  .length}")
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
//                              _onAlertWithCustomContentPressed(index);
//                            });
                            Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => AddingTag(index)),
                            );
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

  _onAlertWithCustomContentPressed(index) async {
    CustomTags tag;
    TextEditingController tagController_type = new TextEditingController();
    TextEditingController tagController_name = new TextEditingController();

    Alert(
        context: context,
        title: "ADD TAGS",
        content: Column(
          children: <Widget>[
            TagSelect(),
            TextField(
              controller: tagController_name,
              decoration: InputDecoration(
                icon: Icon(EvaIcons.pricetags),
                labelText: 'TAG NAME',
              ),
              onChanged: (_) {
                print(tagController_name.text);
              },
            ),
            SelectedTags(tagController_name.text),
//            Container(
//              height: 30,
//              width: 30,
//              //color: Colors.blueGrey,
//              child: IconButton(
//                padding: EdgeInsets.all(0),
//                //color: Colors.white,
//                icon: Icon(Icons.add),
//                onPressed: () {
//                  setState(() {
//                    _count++;
//                    _items.add(_count.toString());
//                    //_items.removeAt(3); _items.removeAt(10);
//                  });
//                },
//              ),
//            ),
//            _tags1,
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                print(selectedItem);
//                tag = new CustomTags(
//                    tagController_type.text, tagController_name.text);


              });
              Navigator.pop(context);
            },
            child: Text(
              "ADD TAG",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
//    _tagText(index, tag);
  }





  _tagText(index, tag) {
    List<Feeds> changedFeeds = [];
    List<CustomTags> previousTags = [];
    bool flag = false;
    int startIndex = feedData[index].feed.selection.baseOffset;
    int endIndex = feedData[index].feed.selection.extentOffset;
    int textLength = feedData[index].feed.text.length;

    previousTags = feedData[index].tags;

    /// adding the data inside the changed Data:
    for (int i = 0; i < index; i++) {
      changedFeeds.add(feedData[i]);
    }

    /// selected type
    ///
    if (startIndex == endIndex) {
      print("Not selected ! ");
    } else if (startIndex == 0 && endIndex == textLength) {
      /// full text selected.
      flag = true;
      feedData[index].addTags(tag);
    } else if (startIndex == 0) {
      /// text splits into 2 .
      /// upper part  selected.
      Feeds selectedFeed = Feeds(
        TextEditingController(
            text: feedData[index]
                .feed
                .text
                .substring(startIndex, endIndex)
                .trim()),
      );
      Feeds unselectedFeed = Feeds(
        TextEditingController(
            text: feedData[index]
                .feed
                .text
                .substring(endIndex, textLength)
                .trim()),
      );

      /// previous tags.
      selectedFeed.setTag(previousTags);
      unselectedFeed.setTag(previousTags);

      /// adding the new tag to the selected tag.
      selectedFeed.addTags(tag);

      /// pushing into the list in order.
      changedFeeds.add(selectedFeed);
      changedFeeds.add(unselectedFeed);
    } else if (endIndex == textLength) {
      /// text splits into 2 .
      /// lower part selected .
      Feeds unselectedFeed = Feeds(
        TextEditingController(
            text: feedData[index].feed.text.substring(0, startIndex).trim()),
      );
      Feeds selectedFeed = Feeds(
        TextEditingController(
            text: feedData[index]
                .feed
                .text
                .substring(startIndex, endIndex)
                .trim()),
      );

      /// previous tags.
      selectedFeed.setTag(previousTags);
      unselectedFeed.setTag(previousTags);

      /// adding the new tag to the selected tag.
      selectedFeed.addTags(tag);

      /// pushing into the list in order.
      changedFeeds.add(unselectedFeed);
      changedFeeds.add(selectedFeed);
    } else {
      /// text splits into 3.
      Feeds upperUnselectedFeed = Feeds(
        TextEditingController(
            text: feedData[index].feed.text.substring(0, startIndex).trim()),
      );
      Feeds selectedFeed = Feeds(
        TextEditingController(
            text: feedData[index]
                .feed
                .text
                .substring(startIndex, endIndex)
                .trim()),
      );
      Feeds lowerUnselectedFeed = Feeds(
        TextEditingController(
            text: feedData[index]
                .feed
                .text
                .substring(endIndex, textLength)
                .trim()),
      );

      /// previous Tags
      upperUnselectedFeed.setTag(previousTags);
      selectedFeed.setTag(previousTags);
      lowerUnselectedFeed.setTag(previousTags);

      /// adding the new tag to the selected tag.
      selectedFeed.addTags(tag);

      /// pushing into the list in order.
      changedFeeds.add(upperUnselectedFeed);
      changedFeeds.add(selectedFeed);
      changedFeeds.add(lowerUnselectedFeed);
    }

    for (int i = index + 1; i < feedData.length; i++) {
      changedFeeds.add(feedData[i]);
    }

    /// update the feedData to changedFeeds.
    if (!flag) feedData = changedFeeds;
  }

//  Widget get _tags1 {
//    return Tags(
//      key: _tagStateKey,
//      columns: _column,
//      itemCount: _items.length,
//      itemBuilder: (index) {
//        final item = _items[index];
//
//        return ItemTags(
//          key: Key(index.toString()),
//          index: index,
//          title: "Tags",
//          pressEnabled: false,
////          activeColor: Colors.blueGrey[600],
////          singleItem: _singleItem,
////          splashColor: Colors.green,
//          combine: ItemTagsCombine.withTextBefore,
////          image: index > 0 && index < 5
////              ? ItemTagsImage(
////              child: Image.network(
////                "http://www.clipartpanda.com/clipart_images/user-66327738/download",
////                width: 16 * _fontSize / 14,
////                height: 16 * _fontSize / 14,
////              ))
////              : (1 == 1
////              ? ItemTagsImage(
////            image: NetworkImage(
////                "https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
////          )
////              : null),
////          icon: (item == '0' || item == '1' || item == '2')
////              ? ItemTagsIcon(
////            icon: _icon[int.parse(item)],
////          )
////              : null,
//          removeButton: ItemTagsRemoveButton(
//            onRemoved: () {
//              setState(() {
//                _items.removeAt(index);
//              });
//              return true;
//            },
//          ),
//          textStyle: TextStyle(
//            fontSize: _fontSize,
//          ),
//        );
//      },
//    );
//  }
}
