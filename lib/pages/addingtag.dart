import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import "package:flutter/material.dart";
import 'package:flutter_tags/flutter_tags.dart';
import 'package:journal/data/data.dart';

class AddingTag extends StatefulWidget {
  ///Selected index and  Texts starting and ending Text.
  final index;
  final start;
  final end;
  final day;

  AddingTag(this.day, this.index, this.start, this.end);

  @override
  _AddingTagState createState() => _AddingTagState();
}

class _AddingTagState extends State<AddingTag> {


  /// TagTypes.
  List<String> tagTypes = [
    "Emotion", "Person", "Place", "Custom"
  ];
  String selectedItem = 'Emotion';
  TextEditingController _controller = new TextEditingController();


  final List<String> _list = [
  ];
  final List<CustomTags> TagList = [
  ];

  int _count = 0;
  int _column = 0;
  double _fontSize = 20;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items;
  List _type;
  List<CustomTags> _addingTagList;
  void initState() {
    super.initState();
    _items = _list.toList();
    _type = _list.toList();
    _addingTagList = [
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBackOutline,
            color: Color(0xffFF7582),
          ),
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "AddTags",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 0.5))),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: DropdownButton<String>(
                          value: selectedItem,
                          onChanged: (String string) {
                            setState(() {
                              selectedItem = string;
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return tagTypes.map<Widget>((String item) {
                              return Text(item);
                            }).toList();
                          },
                          items: tagTypes.map((String item) {
                            return DropdownMenuItem<String>(
                              child: Text(item),
                              value: item,
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            icon: Icon(EvaIcons.pricetags),
                            labelText: 'TAG NAME',
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        //color: Colors.blueGrey,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          //color: Colors.white,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              if (_controller.text != "") {
                                _count++;
                                _items.add(_controller.text);
                                _type.add(selectedItem);
                                CustomTags tag = new CustomTags(
                                    selectedItem, _controller.text);
                                _addingTagList.add(tag);
                                _controller.text = "";
                              }
                              //_items.removeAt(3); _items.removeAt(10);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            _tags1,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: RaisedButton(
                    onPressed: () {
                      _tagText(widget.index, _addingTagList);
                      if (_count != 0)
                        Navigator.pop(context, _addingTagList);
                    },
                    child: Text(
                        'Add Tags',
                        style: TextStyle(fontSize: 20)
                    ),
                  ),
                )
          ])),
        ],
      ),
    );
  }

  Widget get _tags1 {
    return Tags(
      key: _tagStateKey,
      columns: _column,
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];
        final type = _type[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          pressEnabled: false,
          combine: ItemTagsCombine.withTextAfter,
          // ignore: unrelated_type_equality_checks
          icon: type == "Emotion" ? ItemTagsIcon(
            icon: Icons.insert_emoticon,
          ) : type == "Person" ? ItemTagsIcon(
            icon: Icons.person_outline,
          ) : type == "Place" ? ItemTagsIcon(
            icon: Icons.pin_drop,
          ) : type == "Custom" ? ItemTagsIcon(
            icon: Icons.loyalty,
          ) : null,
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                _items.removeAt(index);
                _type.removeAt(index);
                _addingTagList.removeAt(index);
              });
              return true;
            },
          ),
          textStyle: TextStyle(
            fontSize: _fontSize,
          ),
        );
      },
    );
  }

  _tagText(index, newTagList) {
    List<Feeds> changedFeeds = [];
    List<CustomTags> previousTags = [];
    bool flag = false;
    int day = widget.day;
    int startIndex = widget.start;
    int endIndex = widget.end;
    int textLength = data.dailyFeeds[day].feedData[index].feed.text.length;

    previousTags = data.dailyFeeds[day].feedData[index].tags;

    /// adding the data inside the changed Data:
    for (int i = 0; i < index; i++) {
      changedFeeds.add(data.dailyFeeds[day].feedData[i]);
    }

    /// selected type
    if ((startIndex == endIndex) ||
        (startIndex == 0 && endIndex == textLength)) {
      /// full text selected.
      flag = true;
      for (CustomTags tag in newTagList)
        data.dailyFeeds[day].feedData[index].addTags(tag);
    } else if (startIndex == 0) {
      /// text splits into 2 .
      /// upper part  selected.
      Feeds selectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index]
                .feed
                .text
                .substring(startIndex, endIndex)
                .trim()),
      );
      Feeds unselectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index]
                .feed
                .text
                .substring(endIndex, textLength)
                .trim()),
      );

      /// previous tags.
      selectedFeed.setTag(previousTags);
      unselectedFeed.setTag(previousTags);

      /// adding the new tag to the selected tag.
      for (CustomTags tag in newTagList)
        selectedFeed.addTags(tag);

      /// pushing into the list in order.
      changedFeeds.add(selectedFeed);
      changedFeeds.add(unselectedFeed);
    } else if (endIndex == textLength) {
      /// text splits into 2 .
      /// lower part selected .
      Feeds unselectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index].feed.text.substring(
                0, startIndex).trim()),
      );
      Feeds selectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index]
                .feed
                .text
                .substring(startIndex, endIndex)
                .trim()),
      );

      /// previous tags.
      selectedFeed.setTag(previousTags);
      unselectedFeed.setTag(previousTags);

      /// adding the new tag to the selected tag.
      for (CustomTags tag in newTagList)
        selectedFeed.addTags(tag);

      /// pushing into the list in order.
      changedFeeds.add(unselectedFeed);
      changedFeeds.add(selectedFeed);
    } else {
      /// text splits into 3.
      Feeds upperUnselectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index].feed.text.substring(
                0, startIndex).trim()),
      );
      Feeds selectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index]
                .feed
                .text
                .substring(startIndex, endIndex)
                .trim()),
      );
      Feeds lowerUnselectedFeed = Feeds(
        TextEditingController(
            text: data.dailyFeeds[day].feedData[index]
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
      for (CustomTags tag in newTagList)
        selectedFeed.addTags(tag);

      /// pushing into the list in order.
      changedFeeds.add(upperUnselectedFeed);
      changedFeeds.add(selectedFeed);
      changedFeeds.add(lowerUnselectedFeed);
    }

    for (int i = index + 1; i < data.dailyFeeds[day].feedData.length; i++) {
      changedFeeds.add(data.dailyFeeds[day].feedData[i]);
    }

    /// update the feedData to changedFeeds.
    if (!flag) data.dailyFeeds[day].feedData = changedFeeds;
  }

}
