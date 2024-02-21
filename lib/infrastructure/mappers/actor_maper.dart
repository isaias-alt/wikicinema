import 'package:wikicinema/domain/entities/actor.dart';
import 'package:wikicinema/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: (cast.profilePath != null)
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg',
        character: cast.character,
      );
}
