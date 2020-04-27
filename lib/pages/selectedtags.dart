import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SelectedTags extends StatefulWidget {
  String tagName;

  SelectedTags(this.tagName);

  @override
  _SelectedTagsState createState() => _SelectedTagsState();
}

class _SelectedTagsState extends State<SelectedTags> {
  final List<String> _list = [
    '0',
  ];
  int _count = 0;
  int _column = 0;
  double _fontSize = 20;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items;

  @override
  void initState() {
    super.initState();
    _items = _list.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(widget.tagName),
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
          _tags1,
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
          title: widget.tagName,
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
