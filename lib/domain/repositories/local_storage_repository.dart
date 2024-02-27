import 'package:wikicinema/domain/entities/movie.dart';

abstract class LocalStorageRespository {
  Future<void> toggleFavorite(Movie movieId);

  Future<bool> isMovieFavorite(int id);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
