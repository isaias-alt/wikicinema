import 'package:wikicinema/domain/datasources/local_storage_datasource.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/domain/repositories/local_storage_repository.dart';

class LocalRepositoryImpl extends LocalStorageRespository {
  final LocalStorageDatasource datasource;

  LocalRepositoryImpl({required this.datasource});
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
