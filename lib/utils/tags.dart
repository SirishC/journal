import 'dart:convert';

import 'package:flutter/services.dart';

class Tags {
  String keyword;
  int id;

  Tags({
    this.keyword,
    this.id,
  });

  factory Tags.fromJson(Map<String, dynamic> parsedJson) {
    return Tags(
      keyword: parsedJson['keyword'] as String,
      id: parsedJson['id'],
    );
  }
}

class TagsViewModel {
  static List<Tags> tags;

  static Future loadTags() async {
    try {
      tags = new List<Tags>();
      String jsonString = await rootBundle.loadString('assets/jsons/tags.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['tags'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        tags.add(new Tags.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}
