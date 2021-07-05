class MovieList {
  late int _page;
  late int _total_results;
  late int _total_pages;
  late List<Movie> _results;

  MovieList(this._page, this._total_pages, this._total_results, this._results);

  MovieList.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];

    List<Movie> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Movie result = Movie.fromJson(parsedJson['results'][i]);
      temp.add(result);
    }

    _results = temp;
  }

  List<Movie> get results => _results;

  int get total_pages => _total_pages;

  int get total_results => _total_results;

  int get page => _page;
}

class Movie {
  late int _vote_count;
  late int _id;
  late String _video;
  late String _vote_average;
  late String _title;
  late String _popularity;
  late String _poster_path;
  late String _original_language;
  late String _original_title;
  late String _genre_ids;
  late String _backdrop_path;
  late String _adult;
  late String _overview;
  late String _release_date;

  Movie();

  // convenience constructor to create a favorite object
  Movie.fromMap(Map<String, dynamic> map) {
    _id = map[columnId];
    _title = map[columnTitle];
    _overview = map[columnOverview];
    _vote_average = map[columnVoteAverage];
    _poster_path = map[columnPosterPath];
    _release_date = map[columnReleaseDate];
    _vote_count = map[columnVoteCount];
    _video = map[columnVideo];
    _popularity = map[columnPopularity];
    _original_language = map[columnOriginalLanguage];
    _original_title = map[columnOriginalTitle];
    _genre_ids = map[columnGenreIds];
    _backdrop_path = map[columnBackdropPath];
    _adult = map[columnAdult];
  }
  
  // convenience method to create a Map from this favorite object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnOverview: overview,
      columnVoteAverage: vote_average,
      columnPosterPath: poster_path,
      columnReleaseDate: release_date,
      columnVoteCount: _vote_count,
      columnVideo: _video,
      columnPopularity: _popularity,
      columnOriginalLanguage: _original_language,
      columnOriginalTitle: _original_title,
      columnGenreIds: _genre_ids,
      columnBackdropPath: _backdrop_path,
      columnAdult: _adult,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    _vote_count = parsedJson['vote_count'];
    _id = parsedJson['id'];
    _video = parsedJson['video'].toString();
    _vote_average = parsedJson['vote_average'].toString();
    _title = parsedJson['title'];
    _popularity = parsedJson['popularity'].toString();
    _poster_path = parsedJson['poster_path'];
    _original_language = parsedJson['original_language'];
    _original_title = parsedJson['original_title'];

    List<int> temp = [];
    for (int i = 0; i < parsedJson['genre_ids'].length; i++) {
      int result = parsedJson['genre_ids'][i];
      temp.add(result);
    }

    _genre_ids = temp.toString();

    _backdrop_path = parsedJson['backdrop_path'];
    _adult = parsedJson['adult'].toString();
    _overview = parsedJson['overview'];
    _release_date = parsedJson['release_date'];
  }

  // GETTER
  String get release_date => _release_date;

  String get overview => _overview;

  String get adult => _adult;

  String get backdrop_path => _backdrop_path;

  String get genre_ids => _genre_ids;

  String get original_title => _original_title;

  String get original_language => _original_language;

  String get poster_path => _poster_path;

  String get popularity => _popularity;

  String get title => _title;

  String get vote_average => _vote_average;

  String get video => _video;

  int get id => _id;

  int get vote_count => _vote_count;

  //SETTER
  set release_date(value) => _release_date = value;

  set overview(value) => _overview = value;

  set adult(value) => _adult = value;

  set backdrop_path(value) => _backdrop_path = value;

  set genre_ids(value) => _genre_ids = value;

  set original_title(value) => _original_title = value;

  set original_language(value) => _original_language = value;

  set poster_path(value) => _poster_path = value;

  set popularity(value) => _popularity = value;

  set title(value) => _title = value;

  set vote_average(value) => _vote_average = value;

  set video(value) => _video = value;

  set id(value) => _id = value;

  set vote_count(value) => _vote_count = value;
}

// database table and column names
final String tableFavorite = 'favorites';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnOverview = 'overview';
final String columnVoteAverage = 'vote_average';
final String columnPosterPath = 'poster_path';
final String columnReleaseDate = 'release_date';
final String columnVoteCount = 'vote_count';
final String columnVideo = 'video';
final String columnPopularity = 'popularity';
final String columnOriginalLanguage = 'original_language';
final String columnOriginalTitle = 'original_title';
final String columnGenreIds = 'genre_ids';
final String columnBackdropPath = 'backdrop_path';
final String columnAdult = 'adult';
