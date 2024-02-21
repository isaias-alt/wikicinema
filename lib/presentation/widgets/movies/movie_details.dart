import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/presentation/providers/actors/actors_by_movie_provider.dart';

import 'actors_listview.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* title
        _MovieTitle(movie: movie),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Descripción
            _MovieDescription(movie: movie),

            //* Generos
            _MovieGender(movie: movie),

            //* Actors
            _ActorsByMovie(movieId: movie.id.toString()),

            const SizedBox(height: 50),
          ],
        ),
      ],
    );
  }
}

class _MovieTitle extends StatelessWidget {
  final Movie movie;

  const _MovieTitle({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Text(
          movie.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  final Movie movie;

  const _MovieDescription({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        child: Text(
          movie.overview,
          style: textStyles.labelLarge,
        ),
      ),
    );
  }
}

class _MovieGender extends StatelessWidget {
  final Movie movie;

  const _MovieGender({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Wrap(
        children: [
          ...movie.genreIds.map(
            (gender) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(gender),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text('Cast no disponible'),
      );
    }
    final actors = actorsByMovie[movieId]!;

    return ActorsListview(actors: actors);
  }
}
