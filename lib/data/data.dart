import 'dart:io';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

/// CustomTag class.
class CustomTags {
  String type;
  String name;
  CustomTags(this.type, this.name);
}


/// List of Feeds and lists of tags.
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


/// date wise feeds.
class DailyFeeds {
  String date;
  List<Feeds> feedData = [
    Feeds(TextEditingController()),
  ];

  DailyFeeds(this.date);
}


/// Overall Data.
class Data {
  List<DailyFeeds> dailyFeeds = [
    DailyFeeds(formatDate(DateTime.now(), [ M, ',', dd, ',', yyyy]),)
  ];


  add(date) {
    DailyFeeds newfeed = DailyFeeds(date);
    this.dailyFeeds.add(newfeed);
  }


  bool isContains(date) {
    for (int i = 0; i < dailyFeeds.length; i++) {
      if (dailyFeeds[i].date == date) {
        return true;
      }
    }
    return false;
  }


  int getItemByDate(date) {
    for (int i = 0; i < dailyFeeds.length; i++) {
      if (dailyFeeds[i].date == date) {
        return i;
      }
    }
    return -1;
  }
}


/// Object containing overall data .
Data data = new Data();