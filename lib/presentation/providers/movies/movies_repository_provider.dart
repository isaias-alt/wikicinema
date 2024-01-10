import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/infrastructure/datasources/moviedb_datasource.dart';
import 'package:wikicinema/infrastructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider<MovieRepositoryImpl>((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
