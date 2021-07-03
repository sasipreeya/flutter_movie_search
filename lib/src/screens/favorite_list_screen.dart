import 'package:flutter/material.dart';
import 'package:movie_search_app/src/databases/favorite_database.dart';
import 'package:movie_search_app/src/models/favorite_model.dart';
import 'favorite_screen.dart';

class FavoriteListPage extends StatefulWidget {
  FavoriteListPage({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  List<Favorite> favoriteList = [];

  @override
  void initState() {
    super.initState();
    _queryAll();
  }

  _queryAll() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Favorite> item = await helper.queryAll();
    setState(() {
      favoriteList.clear();
      if (item != null) {
        favoriteList = item;
      } else {
        favoriteList.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Favorite>>(
          builder: (context, favoriteListSnap) {
            if (favoriteListSnap.connectionState == ConnectionState.none &&
                favoriteListSnap.hasData == null) {
              return Container();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteList.length,
                    itemBuilder: (context, index) {
                      final item = favoriteList[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage(favorite: item)))
                          .then((value) => { _queryAll() }),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            title: Text(item.title.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              children: [
                                Text(item.releaseDate.toString()),
                                Text(item.overview.toString(), maxLines: 4, style: TextStyle(color: Colors.black),)
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start
                            ),
                            leading: Image.network('https://image.tmdb.org/t/p/w92${item.posterPath}'),
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
              ]
            );
          },
        ));
  }
}
