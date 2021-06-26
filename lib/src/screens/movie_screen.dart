import 'package:flutter/material.dart';
import 'package:movie_search_app/src/screens/search_screen.dart';

class MoviePage extends StatefulWidget {
  MoviePage({Key? key, required this.movie})
      : super(key: key);
  final dynamic movie;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie['title']),
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
                child: Image.network('https://image.tmdb.org/t/p/w92${widget.movie['poster_path']}', fit: BoxFit.fill),
                width: 150,
                height: 250,
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.movie['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text('Average vote: ${widget.movie['vote_average']}', style: TextStyle(fontSize: 14))
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(widget.movie['overview'], style: TextStyle(fontSize: 14))
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
