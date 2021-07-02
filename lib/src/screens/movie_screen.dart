import 'package:flutter/material.dart';
import 'package:movie_search_app/src/models/movie_model.dart';
import 'package:movie_search_app/src/databases/favorite_database.dart';

class MoviePage extends StatefulWidget {
  MoviePage({Key? key, required this.movie})
      : super(key: key);
  final Movie movie;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  _read(int id, Movie movie) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Favorite item = await helper.queryFavorite(id);
    return item;
  }

  _save(Movie item) async {
    Favorite fav = Favorite();
    fav.id = item.id;
    fav.title = item.title;
    fav.overview = item.overview;
    fav.voteAverage = item.vote_average.toString();
    fav.posterPath = item.poster_path;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(fav);
    print('inserted row: $id');
  }

  _delete(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.deleteFavorite(id);
    print('deleted row: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.title),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Icon(
                    Icons.search
                ),
              )
            ),
          ]
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                child: Image.network('https://image.tmdb.org/t/p/w92${widget.movie.poster_path}', fit: BoxFit.fill),
                width: 150,
                height: 250,
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.movie.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text('Average vote: ${widget.movie.vote_average}', style: TextStyle(fontSize: 14))
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.movie.overview, style: TextStyle(fontSize: 14))
            ),
            Container(
              margin: const EdgeInsets.only(top: 100.0),
              child:
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: Text('Favorite'), 
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    ),
                  ),
                  width: double.infinity,
                )
            ),
          ]),
        )
    );
  }
}
