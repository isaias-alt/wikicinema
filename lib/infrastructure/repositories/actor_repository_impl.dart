import 'package:wikicinema/domain/datasources/actors_datasource.dart';
import 'package:wikicinema/domain/entities/actor.dart';
import 'package:wikicinema/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorRepositoryImpl({required this.actorsDatasource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorsDatasource.getActorsByMovie(movieId);
  }
}
