import '../resources/api_provider.dart';
import '../models/movie_model.dart';

class MoviesBloc {
  final _apiProvider = ApiProvider();
  Future<MovieModel> fetchAllMovies(String query, int page) async {
    MovieModel movieModel = (await _apiProvider.fetchAllMovies(query, page));
    return movieModel;
  }
}

final bloc = MoviesBloc();
