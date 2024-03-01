import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/presentation/providers/providers.dart';
import 'package:wikicinema/presentation/widgets/widgets.dart';

final similarMoviesProviders = FutureProvider.family(
  (ref, int movieId) {
    final movieRepository = ref.watch(movieRepositoryProvider);
    return movieRepository.getSimilarMovies(movieId);
  },
);

class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMovie = ref.watch(similarMoviesProviders(movieId));

    return similarMovie.when(
      data: (movies) => _Recomendations(movies: movies),
      error: (error, stackTrace) =>
          const Center(child: Text('No se puedo cargar películas similares')),
      loading: () => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MovieHorizontalListview(title: 'Recomendaciones', movies: movies),
    );
  }
}
