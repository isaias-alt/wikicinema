import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/domain/entities/actor.dart';

import 'actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    final getActors = ref.watch(actorRepositoryProvider).getActorsByMovie;
    return ActorsByMovieNotifier(getActors: getActors);
  },
);

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
