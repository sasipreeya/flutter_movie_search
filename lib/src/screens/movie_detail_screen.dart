import 'package:flutter/material.dart';
import 'package:movie_search_app/src/models/model.dart';
import 'package:movie_search_app/src/databases/database.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({Key? key, required this.movie})
      : super(key: key);
  final Movie movie;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _read(widget.movie.id, widget.movie);
  }

  _read(int id, Movie movie) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Movie item = await helper.queryFavorite(id);
    // ignore: unnecessary_null_comparison
    if (item == null) {
      setState(() {
        isFavorite = false;
      });
    } else {
      setState(() {
        isFavorite = true;
      });
    }
    return item;
  }

  _save(Movie item) async {
    Movie fav = Movie();
    fav.id = item.id;
    fav.title = item.title;
    fav.overview = item.overview;
    fav.vote_average = item.vote_average.toString();
    fav.poster_path = item.poster_path;
    fav.release_date = item.release_date;
    fav.vote_count = item.vote_count;
    fav.video = item.video.toString();
    fav.popularity = item.popularity;
    fav.original_language = item.original_language;
    fav.original_title = item.original_title;
    fav.genre_ids = item.genre_ids;
    fav.backdrop_path = item.backdrop_path;
    fav.adult = item.adult.toString();
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insertFavorite(fav);
    print('inserted row: $id');
    setState(() {
      isFavorite = true;
    });
  }

  _delete(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.deleteFavorite(id);
    print('deleted row: $id');
    setState(() {
      isFavorite = false;
    });
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
                    onPressed: () {
                      if (isFavorite == false) {
                        _save(widget.movie);
                      } else {
                        _delete(widget.movie.id);
                      }
                    }, 
                    child: isFavorite == false ? Text('Add to favorite') : Text('Remove from favorite'), 
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
