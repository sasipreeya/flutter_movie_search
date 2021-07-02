// @dart=2.9
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableFavorite = 'favorites';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnOverview = 'overview';
final String columnVoteAverage = 'vote_average';
final String columnPosterPath = 'poster_path';

// data model class
class Favorite {

  int id;
  String title;
  String overview;
  String voteAverage;
  String posterPath;

  Favorite();
  
  // convenience constructor to create a favorite object
  Favorite.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    overview = map[columnOverview];
    voteAverage = map[columnVoteAverage];
    posterPath = map[columnPosterPath];
  }
  
  // convenience method to create a Map from this favorite object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnOverview: overview,
      columnVoteAverage: voteAverage,
      columnPosterPath: posterPath,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;
  
  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  
  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  
  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  
  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableFavorite ("
          "$columnId INTEGER PRIMARY KEY,"
          "$columnTitle TEXT,"
          "$columnOverview TEXT,"
          "$columnVoteAverage TEXT,"
          "$columnPosterPath TEXT"
          ")",
    );
  }
  
  // Database helper methods:
  Future<int> insert(Favorite item) async {
    Database db = await database;
    int id = await db.insert(tableFavorite, item.toMap());
    return id;
  }
  
  Future<Favorite> queryFavorite(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableFavorite,
        columns: [columnId, columnTitle, columnOverview, columnVoteAverage],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Favorite.fromMap(maps.first);
    }
    return null;
  }

  Future<void> deleteFavorite(int id) async {
    Database db = await database;
    await db.delete(
      tableFavorite,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
