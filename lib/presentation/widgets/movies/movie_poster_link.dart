import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wikicinema/domain/entities/movie.dart';

class MoviesPosterLink extends StatelessWidget {
  final Movie movies;

  const MoviesPosterLink({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movies.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(movies.posterPath),
        ),
      ),
    );
  }
}
