import 'dart:io';
import 'package:flutter/material.dart';

class CustomTags {
  String type;
  String name;

  CustomTags(this.type, this.name);
}

class Feeds {
  TextEditingController feed;

  List<CustomTags> tags = [];

  Feeds(this.feed);

  addTags(CustomTags tag) {
    tags.add(tag);
  }

  setTag(List<CustomTags> newTags) {
    for (CustomTags tags in newTags) {
      this.tags.add(tags);
    }
  }
}

List<Feeds> feedData = [
  Feeds(TextEditingController()),
];

//class Feeds {
//
//  List<TextEditingController> testFeed = [
//    init
//  ];
//  List<Tags>
//  Feeds(String date, String feed) {
//    this.date = date;
//    addFeed(feed);
//  }
//
//  void addFeed(String feed) {
//    feeds.add(feed);
//  }
//}
//
//// list of Feeds.
//class Data {
//  final List<Feeds> items = [];
//  int pos = null;
//
//  bool containsKey(String date) {
//    for (int i = 0; i < items.length; i++)
//      if (items[i].date == date) {
//        pos = i;
//        return true;
//      }
//    return false;
//  }
//
//  void add(String date, String feed) {
//    if (!items.isEmpty) items.clear();
//    if (!data.containsKey(date)) {
//      items.add(Feeds(date, feed));
//    } else {
//      items[pos].addFeed(feed);
//    }
//  }
//
//  int getKey(String date) {
//    if (!data.containsKey(date)) {
//    } else {
//      for (int i = 0; i < items.length; i++) {
//        if (items[i].date == date) return i;
//      }
//    }
//    return 0;
//  }
//
//  String getEvent(String date) {
//    if (data.containsKey(date)) {
//      for (int i = 0; i < items.length; i++) {
//        if (items[i].date == date) return items[i].feeds[0];
//      }
//    }
//    return "";
//  }
//}
