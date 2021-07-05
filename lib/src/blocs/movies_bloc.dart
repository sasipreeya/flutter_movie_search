import '../resources/api_provider.dart';
import '../models/model.dart';

class MoviesBloc {
  final _apiProvider = ApiProvider();
  Future<MovieList> fetchAllMovies(String query, int page) async {
    MovieList movieList = (await _apiProvider.fetchAllMovies(query, page));
    return movieList;
  }
}

final bloc = MoviesBloc();
