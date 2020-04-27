import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import "package:flutter/material.dart";
import 'package:flutter_tags/flutter_tags.dart';

class AddingTag extends StatefulWidget {
  final index;

  AddingTag(this.index);

  @override
  _AddingTagState createState() => _AddingTagState();
}

class _AddingTagState extends State<AddingTag> {
  final List<String> _list = [];
  int _count = 0;
  int _column = 0;
  double _fontSize = 20;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items;

  void initState() {
    super.initState();
    _items = _list.toList();
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
                              _items.add(_count.toString());
                              //_items.removeAt(3); _items.removeAt(10);
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        //color: Colors.grey,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          //color: Colors.white,
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {
                              _items = _list.toList();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            _tags1,
//                Container(
//                    padding: EdgeInsets.all(20),
//                    child: Column(
//                      children: <Widget>[
//                        Divider(
//                          color: Colors.blueGrey,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.symmetric(vertical: 20),
//                          child: Text(_onPressed),
//                        ),
//                      ],
//                    )),
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

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: "Sirish",
          pressEnabled: false,
//          activeColor: Colors.blueGrey[600],
//          singleItem: _singleItem,
//          splashColor: Colors.green,
          combine: ItemTagsCombine.withTextBefore,
//          image: index > 0 && index < 5
//              ? ItemTagsImage(
//              child: Image.network(
//                "http://www.clipartpanda.com/clipart_images/user-66327738/download",
//                width: 16 * _fontSize / 14,
//                height: 16 * _fontSize / 14,
//              ))
//              : (1 == 1
//              ? ItemTagsImage(
//            image: NetworkImage(
//                "https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
//          )
//              : null),
//          icon: (item == '0' || item == '1' || item == '2')
//              ? ItemTagsIcon(
//            icon: _icon[int.parse(item)],
//          )
//              : null,
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
