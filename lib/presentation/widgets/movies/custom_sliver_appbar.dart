import 'package:flutter/material.dart';
import 'package:wikicinema/domain/entities/movie.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const CustomSliverAppBar({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        background: Stack(
          children: [
            _PosterWidget(movie: movie),
            const _BackToGradient(),
          ],
        ),
      ),
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Image.network(
          movie.posterPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BackToGradient extends StatelessWidget {
  const _BackToGradient();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.3],
            colors: [
              Colors.black87,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
