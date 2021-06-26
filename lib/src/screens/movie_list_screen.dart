import 'package:flutter/material.dart';
import 'package:movie_search_app/src/models/movie_model.dart';
import '../blocs/movies_bloc.dart';
import 'movie_screen.dart';

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
  List<dynamic> results = [];
  int total_pages = 1;
  bool pageVisible = false;
  late Future<List<dynamic>> fetch;

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

  Future<List<dynamic>> getMovieList(String value, int page) async {
    MovieModel _movieList = await bloc.fetchAllMovies(value, page);
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

  @override
  void initState() {
    super.initState();

    fetch = getMovieList(widget.searchTerm, page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetch,
          builder: (context, _movieListSnap) {
            if (_movieListSnap.connectionState == ConnectionState.none &&
                _movieListSnap.hasData == null) {
              return Container();
            }
            // return Text('count is ${_movieListSnap.toString()}');
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePage(movie: item))),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              children: [
                                Text(item['release_date']),
                                Text(item['overview'], maxLines: 4, style: TextStyle(color: Colors.black),)
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start
                            ),
                            leading: Image.network('https://image.tmdb.org/t/p/w92${item['poster_path']}'),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1, color: Colors.blue)
                            )
                          ),
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
                      TextButton(onPressed: () { previousPage(); }, child: Text('<')),
                      Text('$page'),
                      TextButton(onPressed: () { nextPage(); }, child: Text('>')),
                    ]
                  )
                )
              ]
            );
          },
        ));
  }
}
