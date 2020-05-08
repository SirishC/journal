/*
table Tags.
[ id  ||  feedNumber || tagType  || tagName  ]
 */

class Tags {
  int _id;

  int _feedNumber;

  String _tagType;

  String _tagName;

  Tags(this._feedNumber, this._tagType, this._tagName);

  Tags.withID(this._id, this._feedNumber, this._tagType, this._tagName);

  int get id => _id;

  int get feedNumber => _feedNumber;

  String get tagType => _tagType;

  String get tagName => _tagName;

  set feedNumber(int number) {
    this._feedNumber = number;
  }

  set tagType(String type) {
    this._tagType = type.toLowerCase().trim();
  }

  set tagName(String name) {
    this._tagName = name.toLowerCase().trim();
  }

  /// converting tag object to map

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }
    map['feedNumber'] = _feedNumber;
    map['tagType'] = _tagType;
    map['tagName'] = _tagName;

    return map;
  }

  Tags.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._feedNumber = map['feedNumber'];
    this._tagType = map['tagType'];
    this._tagName = map['tagName'];
  }
}
