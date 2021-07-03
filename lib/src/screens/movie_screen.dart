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
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _read(widget.movie.id, widget.movie);
  }

  _read(int id, Movie movie) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Favorite item = await helper.queryFavorite(id);
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
    Favorite fav = Favorite();
    fav.id = item.id;
    fav.title = item.title;
    fav.overview = item.overview;
    fav.voteAverage = item.vote_average.toString();
    fav.posterPath = item.poster_path;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(fav);
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
