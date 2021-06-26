import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../models/movie_model.dart';
import 'package:dio/dio.dart';

class MoviesProvider {
  Future<MovieModel> fetchMovieList(String query, int page) async {
    final response = await Dio().get(
      'http://scb-movies-api.herokuapp.com/api/movies/search',
      queryParameters: {'query': query, 'page': page},
      options: Options(headers: {
        'api-key': 'b281db381841c6ec99a6183c9945d76fb6634d60',
      }),
    );
    if (response.statusCode == 200) {
      print("fetch success");
      Map<String, dynamic> parsedJson = json.decode(response.toString());
      return new MovieModel.fromJson(parsedJson);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }
}
