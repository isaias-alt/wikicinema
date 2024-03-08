import 'package:dio/dio.dart';
import 'package:wikicinema/config/constants/environment.dart';
import 'package:wikicinema/domain/datasources/actors_datasource.dart';
import 'package:wikicinema/domain/entities/actor.dart';
import 'package:wikicinema/infrastructure/mappers/actor_maper.dart';
import 'package:wikicinema/infrastructure/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDBKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    try {
      final response = await dio.get('/movie/$movieId/credits');
      final castResponse = CreditsResponse.fromJson(response.data);
      final List<Actor> actors = castResponse.cast
          .map((cast) => ActorMapper.castToEntity(cast))
          .toList();
      return actors;
    } catch (e) {
      throw Exception(e);
    }
  }
}
