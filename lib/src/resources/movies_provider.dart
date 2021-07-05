import 'dart:async';
import 'dart:convert';
import '../models/model.dart';
import 'package:dio/dio.dart';

class MoviesProvider {

  String url = 'http://scb-movies-api.herokuapp.com/api/movies/search';
  String apiKey = 'b281db381841c6ec99a6183c9945d76fb6634d60';

  Future<MovieList> fetchMovieList(String query, int page) async {
    final response = await Dio().get(
      url,
      queryParameters: {'query': query, 'page': page},
      options: Options(headers: {
        'api-key': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      print("fetch success");
      Map<String, dynamic> parsedJson = json.decode(response.toString());
      return new MovieList.fromJson(parsedJson);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }
}
