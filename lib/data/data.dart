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
    /// adding to overall data.
    overallData.addTagCount(tag);
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

class OverallData {
  List<String> tagsUsed = [];
  List<String> emotionTags=[];
  List<String> personTags=[];
  List<String> placeTags=[];
  List<String> userTags=[];
  addTagCount(tag){
    if (!tagsUsed.contains(tag.name))
      tagsUsed.add(tag.name);
    if(tag.type == "Emotion"){
      if(!emotionTags.contains(tag.name))
        emotionTags.add(tag.name);
    }
    else if(tag.type == "Person"){
      if(!personTags.contains(tag.name)){
        personTags.add(tag.name);
      }
    }
    else if(tag.type == "Place"){
      if(!placeTags.contains(tag.name)){
        placeTags.add(tag.name);
      }
    }
    else{
      if(!userTags.contains(tag.name)){
        userTags.add(tag.name);
      }
    }
  }
}

/// Object containing overall data .
Data data = new Data();

OverallData overallData = new OverallData();


/// Dynamic list
List<Feeds> searchData = [];