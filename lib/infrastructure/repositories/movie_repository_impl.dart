import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/domain/datasources/movies_datasource.dart';
import 'package:wikicinema/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl({required this.datasource});
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}