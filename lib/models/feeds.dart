/*
table feeds
[ date || feedNumber || text];
 */

class Feeds {
  int _id;

  String _date;
  int _feedNumber;
  String _feed;

  Feeds(this._date, this._feedNumber, this._feed);

  Feeds.withId(this._id, this._date, this._feedNumber, this._feed);

  int get id => _id;

  String get date => _date;

  int get feedNumber => _feedNumber;

  String get feed => _feed;

  set date(String newDate) {
    this._date = newDate;
  }

  set feedNumber(int newFeedNumber) {
    this._feedNumber = newFeedNumber;
  }

  set feed(String newText) {
    this._feed = newText.trim();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) map['id'] = this._id;
    map['date'] = this._date;
    map['feedNumber'] = this._feedNumber;
    map['feed'] = this._feed;
  }

  Feeds.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._date = map['date'];
    this._feedNumber = map['feedNumber'];
    this._feed = map['feed'];
  }
}
