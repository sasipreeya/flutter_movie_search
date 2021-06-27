class MovieModel {
  late int _page;
  late int _total_results;
  late int _total_pages;
  List<Movie> _results = [];

  MovieModel(this._page, this._total_pages, this._total_results, this._results);

  MovieModel.fromJson(Map<String, dynamic> parsedJson) {
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
  late bool _video;
  late var _vote_average;
  late String _title;
  late double _popularity;
  late String _poster_path;
  late String _original_language;
  late String _original_title;
  late List<int> _genre_ids = [];
  late String _backdrop_path;
  late bool _adult;
  late String _overview;
  late String _release_date;

  Movie(result) {
    _vote_count = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _vote_average = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _poster_path = result['poster_path'];
    _original_language = result['original_language'];
    _original_title = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
    _backdrop_path = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    _release_date = result['release_date'];
  }

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    _vote_count = parsedJson['vote_count'];
    _id = parsedJson['id'];
    _video = parsedJson['video'];
    _vote_average = parsedJson['vote_average'];
    _title = parsedJson['title'];
    _popularity = parsedJson['popularity'];
    _poster_path = parsedJson['poster_path'];
    _original_language = parsedJson['original_language'];
    _original_title = parsedJson['original_title'];

    List<int> temp = [];
    for (int i = 0; i < parsedJson['genre_ids'].length; i++) {
      int result = parsedJson['genre_ids'][i];
      temp.add(result);
    }

    _genre_ids = temp;

    _backdrop_path = parsedJson['backdrop_path'];
    _adult = parsedJson['adult'];
    _overview = parsedJson['overview'];
    _release_date = parsedJson['release_date'];
  }

  String get release_date => _release_date;

  String get overview => _overview;

  bool get adult => _adult;

  String get backdrop_path => _backdrop_path;

  List<int> get genre_ids => _genre_ids;

  String get original_title => _original_title;

  String get original_language => _original_language;

  String get poster_path => _poster_path;

  double get popularity => _popularity;

  String get title => _title;

  double get vote_average => _vote_average;

  bool get video => _video;

  int get id => _id;

  int get vote_count => _vote_count;
}