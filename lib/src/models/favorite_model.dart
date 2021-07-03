// database table and column names
final String tableFavorite = 'favorites';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnOverview = 'overview';
final String columnVoteAverage = 'vote_average';
final String columnPosterPath = 'poster_path';
final String columnReleaseDate = 'release_date';

class Favorite {

  late int id;
  late String title;
  late String overview;
  late String voteAverage;
  late String posterPath;
  late String releaseDate;

  Favorite();
  
  // convenience constructor to create a favorite object
  Favorite.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    overview = map[columnOverview];
    voteAverage = map[columnVoteAverage];
    posterPath = map[columnPosterPath];
    releaseDate = map[columnReleaseDate];
  }
  
  // convenience method to create a Map from this favorite object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnOverview: overview,
      columnVoteAverage: voteAverage,
      columnPosterPath: posterPath,
      columnReleaseDate: releaseDate,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}