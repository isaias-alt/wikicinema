import 'package:flutter/material.dart';
import 'package:wikicinema/config/helpers/human_formats.dart';
import 'package:wikicinema/domain/entities/movie.dart';

class MovieSearchItems extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const MovieSearchItems({
    super.key,
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          //* Image
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                height: 130,
                placeholder:
                    const AssetImage('assets/loaders/bottle-loader.gif'),
                image: NetworkImage(movie.posterPath),
              ),
            ),
          ),

          const SizedBox(width: 10),

          //* Title and Description
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleMedium),
                (movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0, 100)}...')
                    : Text(movie.overview),
                Row(
                  children: [
                    Icon(Icons.star_half_rounded,
                        color: Colors.yellow.shade800),
                    const SizedBox(width: 5),
                    Text(
                      HumanFormats.numbers(movie.voteAverage, 2),
                      style: textStyles.bodyMedium!
                          .copyWith(color: Colors.yellow.shade900),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
