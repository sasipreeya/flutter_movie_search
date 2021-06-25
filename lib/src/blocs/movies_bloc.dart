import '../resources/api_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../models/movie_model.dart';

class MoviesBloc {
  final _apiProvider = ApiProvider();
  Future<MovieModel> fetchAllMovies(String query) async {
    MovieModel movieModel = (await _apiProvider.fetchAllMovies(query));
    return movieModel;
  }
}

final bloc = MoviesBloc();
