import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:journal/models/tags.dart';
import 'package:journal/models/feeds.dart';
import 'dart:io';
import 'dart:async';

//Journal Database;
// Tags
// [ id  ||  feedNumber || tagType    || tagName  ]
// Feeds
// [ id  ||  date       || feedNumber || text     ]

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // singleton class

  DatabaseHelper.createInstance();

  static Database _database;

// tag table
  String tagTable = 'tag_table';

// column name
  String colIdTags = 'id';
  String colFeedNumberTags = 'feedNumber';
  String colTagType = 'tagType';
  String colTagName = 'tagName';

// feed table
  String feedTable = 'feed_table';
  String colIdFeeds = 'id';
  String colDate = 'date';
  String colFeedNumberFeeds = 'feedNumber';
  String colFeed = 'feed';

  factory DatabaseHelper() {
    if (_databaseHelper == null)
      _databaseHelper = DatabaseHelper.createInstance();
    return _databaseHelper;
  }

  ///getter database

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); // path where db is set
    String path = directory.path + 'journal.db';
    var journalDatabase = await openDatabase(path,
        version: 1, onCreate: _createDb); // creating the database
    return journalDatabase;
  }

  // createing  database
  void _createDb(Database db, int newVersion) async {
    String sqlTags =
        'CREATE TABLE $tagTable ($colIdTags ,INTEGER PRIMARY KEY AUTOINCREMENT , $colFeedNumberTags INTEGER , $colTagType TEXT  , $colTagName Text)';
    String sqlFeeds =
        'CREATE TABLE $feedTable($colIdFeeds,INTEGER PRIMARY KEY AUTOINCREMENT , $colDate TEXT , $colFeedNumberFeeds INTEGER , $colFeed TEXT)';
    await db.execute(sqlTags);
    await db.execute(sqlFeeds);
  }

  /// Database  Operation
  /// TAG TABLE .
  /// fetching Tag Table ;
  Future<List<Map<String, dynamic>>> getTagMapList() async {
    Database db = await this.database;
    var result = await db.query(tagTable);
    return result;
  }

  /// inserting data into tags.
  Future<int> insertTag(Tags tags) async {
    Database db = await this.database;
    var result = await db.insert(tagTable, tags.toMap());
    return result;
  }

  /// updating tags .
  Future<int> updateTag(Tags tags) async {
    Database db = await this.database;
    var result = await db.update(tagTable, tags.toMap());
    return result;
  }

  /// deleting tags.
  Future<int> deleteTag(int id) async {
    Database db = await this.database;
    String sql = "DELETE FROM $tagTable WHERE $colIdTags = $id";
    var result = await db.rawDelete(sql);
    return result;
  }

  /// Visualization
  /// Emotions and its count.
  Future<List<Map<String, dynamic>>> getEmotionCount() async {
    Database db = await this.database;
    String type = "emotion";
    String sql =
        "SELECT $colTagName , COUNT(*)EMOTIONCOUNT FROM $tagTable WHERE $colTagType LIKE $type GROUP BY $colTagName";
    var emotionCount = await db.rawQuery(sql);
    return emotionCount;
  }

  /// Persons and its count.
  Future<List<Map<String, dynamic>>> getPersonCount() async {
    Database db = await this.database;
    String type = "person";
    String sql =
        "SELECT $colTagName , COUNT(*) PERSONCOUNT FROM $tagTable WHERE $colTagName LIKE $type GROUP BY $colTagName ORDER BY PERSONCOUNT DESC";
    var personCount = await db.rawQuery(sql);
    return personCount;
  }

  /// Searching.
  Future<List<Map<String, dynamic>>> getTags() async {
    Database db = await this.database;
    String sql = "SELECT DISTINCT $colTagName FROM $tagTable";
    var allTags = db.rawQuery(sql);
    return allTags;
  }

  /// FEEDS TABLE
  /// fetching feeds table
  Future<List<Map<String, dynamic>>> getFeedsMapList() async {
    Database db = await this.database;
    var result = db.query(feedTable);
    return result;
  }

  /// insert feeds
  Future<int> insertFeed(Feeds feed) async {
    Database db = await this.database;
    var result = db.insert(feedTable, feed.toMap());
    return result;
  }

  /// update feeds
  Future<int> updateFeed(Feeds feed) async {
    Database db = await this.database;
    var result = db.update(feedTable, feed.toMap());
    return result;
  }

  Future<int> deleteFeed(int id) async {
    Database db = await this.database;
    String sql = "DELETE FROM $feedTable WHERE $colIdFeeds = $id";
    var result = db.rawDelete(sql);
    return result;
  }

  /// searching display querry using join .
}
