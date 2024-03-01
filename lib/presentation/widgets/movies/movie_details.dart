import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/config/helpers/human_formats.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:wikicinema/presentation/widgets/widgets.dart';

import 'actors_listview.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Title, Overview and Roting
        _MovieSynopsisAndRating(
          movie: movie,
          size: size,
          textStyles: textStyles,
        ),

        //* Gender
        _MovieGender(movie: movie),

        //* Actors
        _ActorsByMovie(movieId: movie.id.toString()),

        //* Videos (if any)
        VideosFromMovie(movieId: movie.id),

        //* Similar Movies
        SimilarMovies(movieId: movie.id),
      ],
    );
  }
}

class _MovieSynopsisAndRating extends StatelessWidget {
  const _MovieSynopsisAndRating({
    required this.movie,
    required this.size,
    required this.textStyles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleLarge),
                Text(movie.overview),

                //* Rating
                MovieRating(voteAverage: movie.voteAverage),

                //* releaseDate
                Row(
                  children: [
                    const Text(
                      'Estreno:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Text(HumanFormats.shortDate(movie.releaseDate))
                  ],
                ),
              ],
            ),
          ),
        ],
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
