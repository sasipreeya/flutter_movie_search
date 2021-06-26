class MovieModel {
  dynamic _page;
  dynamic _total_results;
  dynamic _total_pages;
  List<dynamic> _results = [];

  MovieModel(this._page, this._total_pages, this._total_results, this._results);

  MovieModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _total_results = parsedJson['total_results'];
    _total_pages = parsedJson['total_pages'];

    dynamic temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      dynamic result = parsedJson['results'][i];
      temp.add(result);
    }

    _results = temp;
  }

  List<dynamic> get results => _results;

  dynamic get total_pages => _total_pages;

  dynamic get total_results => _total_results;

  dynamic get page => _page;
}
