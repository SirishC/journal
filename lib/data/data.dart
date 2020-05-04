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


class EmotionStat {
  String emotion;

  int count;

  EmotionStat(this.emotion) {
    count = 0;
  }

  List<EmotionStat> getEmotionStat() {
    List<EmotionStat> emotions = [
    ];
    for (String tag in overallData.tagsUsed) {
      int pos = isContains(emotions, tag);
      if (pos != -1) {
        emotions[pos].count++;
      }
      else {
        emotions.add(EmotionStat(tag));
      }
    }
  }

  isContains(list, item) {
    for (int i = 0; i < list.lenght; i++) {
      if (list[i].emotion == item) {
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

class EmotionCount {
  final String Emotion;
  int count;
  EmotionCount(this.Emotion, this.count);
}
/// Object containing overall data .
Data data = new Data();

OverallData overallData = new OverallData();

///
EmotionStat emotionCount;

/// Dynamic list
List<Feeds> searchData = [];