import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movie_search_app/src/models/movie_model.dart';
import '../blocs/movies_bloc.dart';

class MovieListScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListPage(
        title: 'Movie list',
        searchTerm: '',
      ),
    );
  }
}

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

  Future<List<dynamic>> getMovieList(String value) async {
    MovieModel _movieList = await bloc.fetchAllMovies(value);
    print(_movieList.results[0].toString());
    setState(() {
      List<dynamic> temp = [];
      for (int i = 0; i < _movieList.results.length; i++) {
        temp.add(_movieList.results[i]);
      }
      results = temp;
    });
    return _movieList.results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getMovieList(widget.searchTerm),
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
                  child: ListTile(title: Text(item.title.toString())),
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
