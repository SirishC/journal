import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:journal/data/data.dart';

class AutoCompleteTags {
  String keyword;
  int id;

  AutoCompleteTags({
    this.keyword,
    this.id,
  });

  factory AutoCompleteTags.fromData(name, id) {
    return AutoCompleteTags(
      keyword: name,
      id: id,
    );
  }
}

class TagsViewModel {
  static List<AutoCompleteTags> tags;

  static Future loadTags() async {
    try {
      tags = new List<AutoCompleteTags>();
          for(int i =0;i<overallData.tagsUsed.length;i++){
            tags.add(new AutoCompleteTags.fromData(overallData.tagsUsed[i], i));
          }
    } catch (e) {
      print(e);
    }
  }
}
