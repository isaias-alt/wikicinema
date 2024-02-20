import 'package:flutter/material.dart';
import 'package:wikicinema/domain/entities/movie.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Descripción
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SizedBox(
            child: Text(
              movie.overview,
              style: textStyles.titleMedium,
            ),
          ),
        ),

        //* Generos
        Padding(
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
        ),

        const SizedBox(height: 50),
      ],
    );
  }
}
