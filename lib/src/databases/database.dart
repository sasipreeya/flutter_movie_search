// @dart=2.9
import 'dart:io';
import 'package:movie_search_app/src/models/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

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
          "$columnPosterPath TEXT,"
          "$columnReleaseDate TEXT,"
          "$columnVoteCount INTEGER,"
          "$columnVideo TEXT,"
          "$columnPopularity TEXT,"
          "$columnOriginalLanguage TEXT,"
          "$columnOriginalTitle TEXT,"
          "$columnGenreIds TEXT,"
          "$columnBackdropPath TEXT,"
          "$columnAdult TEXT"
          ")",
    );
  }
  
  // Database helper methods:
  Future<int> insertFavorite(Movie item) async {
    Database db = await database;
    int id = await db.insert(tableFavorite, item.toMap());
    return id;
  }
  
  Future<Movie> queryFavorite(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableFavorite,
        columns: [
          columnId, 
          columnTitle, 
          columnOverview, 
          columnVoteAverage, 
          columnReleaseDate,
          columnVoteCount,
          columnVideo,
          columnPopularity,
          columnOriginalLanguage,
          columnOriginalTitle,
          columnGenreIds,
          columnBackdropPath,
          columnAdult,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Movie.fromMap(maps.first);
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

  Future<List<Movie>> queryAll() async {
    Database db = await database;
    List<Movie> favoriteList = [];
    List<Map> maps = await db.query(tableFavorite);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        favoriteList.add(Movie.fromMap(maps[i]));
      }
      return favoriteList;
    }
    return null;
  }
}
