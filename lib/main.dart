import 'package:flutter/material.dart';
import 'src/screens/search_screen.dart';

void main() {
  runApp(SearchScreen());
}

class SearchScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(title: 'Movie search app'),
    );
  }
}
