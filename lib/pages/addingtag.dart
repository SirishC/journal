import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import "package:flutter/material.dart";
import 'package:flutter_tags/flutter_tags.dart';
import 'package:journal/data/data.dart';

class AddingTag extends StatefulWidget {
  final index;

  AddingTag(this.index);

  @override
  _AddingTagState createState() => _AddingTagState();
}

class _AddingTagState extends State<AddingTag> {
  List<String> tagTypes = [
    "Emotion", "Person", "Place", "Custom"
  ];
  String selectedItem = 'Emotion';
  TextEditingController _controller = new TextEditingController();
  final List<String> _list = [
  ];
  int _count = 0;
  int _column = 0;
  double _fontSize = 20;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items;
  List _type;
  void initState() {
    super.initState();
    _items = _list.toList();
    _type = _list.toList();
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
                              _count++;
                              _items.add(_controller.text);
                              _type.add(selectedItem);
                              _controller.text = "";
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
}
