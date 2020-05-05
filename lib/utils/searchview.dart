import 'package:flutter/material.dart';
import 'package:journal/data/data.dart';
class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child:displayFeeds(searchData[index].feed.text),
                );
              },
              childCount: searchData.length,
//              childCount: 0,
            ),
          )
        ],
      ),
    );
  }
  Widget displayFeeds(String s) {
    return new Card(
      child:ListTile(

        leading: new Icon(
          Icons.event_note,
          color:Color(0xffFF7582) ,
        ),
        title: new Container(
          //margin: const EdgeInsets.all(3.0),
          //color: Colors.amber[600],
          width: 60.0,
          height: 48.0,
          child:new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              new Text(
                data.dailyFeeds[0].date,),
              new Text(
                "happy sirish preethi",
                style: TextStyle(fontWeight: FontWeight.bold,),
              ),
            ],
          ),
        ),
        subtitle: new Text(s,),
//        trailing: Text("happy\nsirish\npreethi",
//          style: TextStyle(fontWeight: FontWeight.bold,),
//
//        ),
      ),
    );
  }
}
