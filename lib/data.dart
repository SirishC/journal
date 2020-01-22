import 'dart:io';

var data = Data();

class Feeds {
  int date = null;
  List<String> feeds = [];

  Feeds(int date, String feed) {
    this.date = date;
    addFeed(feed);
  }

  void addFeed(String feed) {
    feeds.add(feed);
  }
}

// list of Feeds.
class Data {
  final List<Feeds> items = [];
  int pos = null;

  bool containsKey(int date) {
    for (int i = 0; i < items.length; i++)
      if (items[i].date == date) {
        pos = i;
        return true;
      }
    return false;
  }

  void add(int date, String feed) {
    if (!data.containsKey(date)) {
      items.add(Feeds(date, feed));
    } else {
      items[pos].addFeed(feed);
    }
  }

  int getKey(int date) {
    if (!data.containsKey(date)) {
    } else {
      for (int i = 0; i < items.length; i++) {
        if (items[i].date == date) return i;
      }
    }
    return 0;
  }
}
