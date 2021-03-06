import 'package:flutter/material.dart';
import 'package:movie_search_app/src/databases/database.dart';
import 'package:movie_search_app/src/models/model.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail_screen.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key? key, required this.title, required this.searchTerm})
      : super(key: key);
  final String title;
  final String searchTerm;

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  int page = 1;
  int total_pages = 1;
  bool pageVisible = false;
  List<Movie> results = [];
  late Future<List<Movie>> fetch;

  void previousPage() {
    if (page != 1 && page <= total_pages) {
      setState(() {
        page--;
      });
      getMovieList(widget.searchTerm, page);
    }
  }

  void nextPage() {
    if (page < total_pages) {
      setState(() {
        page++;
      });
      getMovieList(widget.searchTerm, page);
    }
  }

  Future<List<Movie>> getMovieList(String value, int page) async {
    MovieList _movieList = await bloc.fetchAllMovies(value, page);
    setState(() {
      results.clear();
      results.addAll(_movieList.results);
      total_pages = _movieList.total_pages;
      if (_movieList.total_pages > 1) {
        pageVisible = true;
      }
    });
    return _movieList.results;
  }

  Future<List<Movie>>  _queryAll() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Movie> item = await helper.queryAll();
    setState(() {
      results.clear();
      if (item != null) {
        results = item;
      } else {
        results.clear();
      }
    });
    return results;
  }

  @override
  void initState() {
    super.initState();
    if (widget.searchTerm != '') {
      fetch = getMovieList(widget.searchTerm, page);
    } else {
      fetch = _queryAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Movie>>(
          future: fetch,
          builder: (context, _movieListSnap) {
            if (_movieListSnap.connectionState == ConnectionState.none &&
                _movieListSnap.hasData == null) {
              return Container();
            }
            return Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final item = results[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailPage(movie: item))).then((value) => {
                                if (widget.searchTerm == '') {
                                  _queryAll()
                                }
                              }),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          title: Text(item.title.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(children: [
                            Text(item.release_date.toString()),
                            Text(
                              item.overview.toString(),
                              maxLines: 4,
                              style: TextStyle(color: Colors.black),
                            )
                          ], crossAxisAlignment: CrossAxisAlignment.start),
                          leading: Image.network(
                              'https://image.tmdb.org/t/p/w92${item.poster_path}'),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.blue))),
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                  visible: pageVisible,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            previousPage();
                          },
                          child: Text('<')),
                      Text('$page'),
                      TextButton(
                          onPressed: () {
                            nextPage();
                          },
                          child: Text('>')),
                    ]))
            ]);
          },
        ));
  }
}
