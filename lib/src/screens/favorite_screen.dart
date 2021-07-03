import 'package:flutter/material.dart';
import 'package:movie_search_app/src/databases/favorite_database.dart';
import 'package:movie_search_app/src/models/favorite_model.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key, required this.favorite})
      : super(key: key);
  final Favorite favorite;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<FavoritePage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _read(widget.favorite.id, widget.favorite);
  }

  _read(int id, Favorite favorite) async {
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

  _save(Favorite item) async {
    Favorite fav = Favorite();
    fav.id = item.id;
    fav.title = item.title;
    fav.overview = item.overview;
    fav.voteAverage = item.voteAverage.toString();
    fav.posterPath = item.posterPath;
    fav.releaseDate = item.releaseDate;
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
          title: Text(widget.favorite.title),
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
                child: Image.network('https://image.tmdb.org/t/p/w92${widget.favorite.posterPath}', fit: BoxFit.fill),
                width: 150,
                height: 250,
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.favorite.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text('Average vote: ${widget.favorite.voteAverage}', style: TextStyle(fontSize: 14))
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.favorite.overview, style: TextStyle(fontSize: 14))
            ),
            Container(
              margin: const EdgeInsets.only(top: 100.0),
              child:
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isFavorite == false) {
                        _save(widget.favorite);
                      } else {
                        _delete(widget.favorite.id);
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
