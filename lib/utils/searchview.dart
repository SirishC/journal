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
                  child: displayFeeds(index),
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

  Widget displayFeeds(index) {
    return new Card(
      child: ListTile(
        leading: new Icon(
          Icons.event_note,
          color: Color(0xffFF7582),
        ),
        title: new Container(
          margin: const EdgeInsets.all(3.0),
          width: 60.0,
          height: 65.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                searchData[index].date,
              ),
              Container(
                height: 48,
                child: ListView.builder(
                  itemCount: searchData[index].feedData.tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int items) =>
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Chip(
                          avatar: Container(
                            child: searchData[index]
                                .feedData.tags[items]

                            ///
                                .type == "Emotion" ? Icon(
                                Icons.insert_emoticon) :
                            searchData[index].feedData
                                .tags[items].type ==

                                ///
                                "Person" ? Icon(Icons.person) :
                            searchData[index].feedData
                                .tags[items].type ==

                                ///
                                "Place" ? Icon(Icons.pin_drop) :
                            searchData[index].feedData
                                .tags[items].type ==

                                ///
                                "Custom"
                                ? Icon(Icons.loyalty)
                                : null,
                          ),
                          label: Text(
                              searchData[index].feedData
                                  .tags[items].name),
                        ),
                      ),
                )
                ,
              )
            ],
          ),
        ),
        subtitle: new Text(
          searchData[index].feedData.feed.text,
        ),
//        ),
      ),
    );
  }
}
