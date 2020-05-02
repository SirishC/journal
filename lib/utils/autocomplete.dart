//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:journal/data/data.dart';
import 'package:journal/utils//tags.dart';

class AutoComplete extends StatefulWidget {
  String selectedText ;
  AutoComplete(this.selectedText);
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {


  GlobalKey<AutoCompleteTextFieldState<AutoCompleteTags>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();

  _AutoCompleteState();

  void _loadData() async {
    await TagsViewModel.loadTags();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          new Column(children: <Widget>[
            searchTextField = AutoCompleteTextField<AutoCompleteTags>(
                style: new TextStyle(color: Colors.black, fontSize: 20.0),
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Container(
                      width: 85.0,
                      height: 30.0,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    filled: true,
                    hintText: 'Search tags',
                    hintStyle: TextStyle(color: Colors.black)),
                itemSubmitted: (item) {
                  setState(() =>
                      searchTextField.textField.controller.text = item.keyword);
                  print("Keyword : ${item.keyword}");
                      _updateSearchData(item.keyword);

                },
                clearOnSubmit: false,
                key: key,
                suggestions: TagsViewModel.tags,
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.keyword,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                      ),
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.keyword.compareTo(b.keyword);
                },
                itemFilter: (item, query) {
                  return item.keyword
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                }),
            //appBar: AppBar(body:searchTextField!=null ?  Text("Yes, search is found") : Text("No search found"))
          ])
        ]));
  }
  _updateSearchData (tagName) async{
    searchData=[];
    for(DailyFeeds dailyfeed in data.dailyFeeds ){
      for(Feeds feed in dailyfeed.feedData){
        if(_isContains(feed ,tagName)){
          searchData.add(feed);
        }
      }
    }
  }
  _isContains(feed , tagName){
    for(CustomTags tag in feed.tags){
      if(tag.name == tagName)
        return true;
    }
    return false;
  }
}
