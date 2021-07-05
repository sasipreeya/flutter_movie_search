import 'package:flutter/material.dart';
import 'package:movie_search_app/src/screens/movie_list_screen.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchTextField = TextEditingController();
  List<String> _history = [];

  void _search(String value) {
    if (value != '') {
      if (_history.contains(value)) {
        var index = _history.indexOf(value);
        setState(() => {
          _history.removeAt(index),
          _history.insert(0, value)
        });
      } else {
        setState(() {
          _history.insert(0, value);
        });
      }
      searchTextField.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListPage(title: 'Movie list', searchTerm: value)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListPage(title: 'Favorite list', searchTerm: ''))),
              child: Icon(
                  Icons.favorite
              ),
            )
          ),
        ]
      ),
      body: Column(
        children: [
          TextField(
            controller: searchTextField,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
              prefixIcon: Icon(Icons.search)
            ),
            autocorrect: false, 
            onSubmitted: (String value) => _search(value),
            style: TextStyle(color: Colors.blue),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Container(
                  child: ListTile(title: Text(item), onTap: () => _search(item),),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.blue))),
                );
              },
            ),
          )
        ]
      )
    );
  }
}