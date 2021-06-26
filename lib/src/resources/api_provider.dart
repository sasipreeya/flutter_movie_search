import 'dart:async';
import 'movies_provider.dart';
import '../models/movie_model.dart';

class ApiProvider {
  final moviesProvider = MoviesProvider();

  Future<MovieModel> fetchAllMovies(String query, int page) {
    return moviesProvider.fetchMovieList(query, page);
  }
}
