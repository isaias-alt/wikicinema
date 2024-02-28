import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/domain/repositories/local_storage_repository.dart';
import 'package:wikicinema/presentation/providers/storage/local_storage_repository_provider.dart';

final favoriteMoviesProviders =
    StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>(
  (ref) {
    final localStorageRespository = ref.watch(localStorageRepositoryProvider);
    return FavoriteMoviesNotifier(
      localStorageRespository: localStorageRespository,
    );
  },
);

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRespository localStorageRespository;

  FavoriteMoviesNotifier({
    required this.localStorageRespository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRespository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRespository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
