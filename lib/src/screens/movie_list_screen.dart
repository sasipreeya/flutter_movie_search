import 'package:flutter/material.dart';
import 'package:movie_search_app/src/models/movie_model.dart';
import '../blocs/movies_bloc.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key? key, required this.title, required this.searchTerm})
      : super(key: key);
  final String title;
  final String searchTerm;

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<dynamic> results = [];
  late Future<List<dynamic>> fetch;

  Future<List<dynamic>> getMovieList(String value) async {
    MovieModel _movieList = await bloc.fetchAllMovies(value);
    setState(() {
      results.addAll(_movieList.results);
    });
    return _movieList.results;
  }

  @override
  void initState() {
    super.initState();

    fetch = getMovieList(widget.searchTerm);
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
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return Container(
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
                        bottom: BorderSide(width: 1, color: Colors.blue))),
                );
              },
            );
          },
        ));
  }
}
