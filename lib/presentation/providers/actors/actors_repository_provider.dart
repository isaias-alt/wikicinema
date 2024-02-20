import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:wikicinema/infrastructure/repositories/actor_repository_impl.dart';

final actorRepositoryProvider = Provider<ActorRepositoryImpl>((ref) {
  return ActorRepositoryImpl(actorsDatasource: ActorMoviedbDatasource());
});
