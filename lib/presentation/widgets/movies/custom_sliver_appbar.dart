import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/presentation/providers/providers.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose<bool, int>(
  (ref, int movieId) {
    final localStorageProvider = ref.watch(localStorageRepositoryProvider);
    return localStorageProvider.isMovieFavorite(movieId);
  },
);

class CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const CustomSliverAppBar({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: size.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
            await Future.delayed(const Duration(milliseconds: 200));
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavorite.when(
            loading: () => const CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border),
            error: (error, stackTrace) => throw UnimplementedError(),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        background: Stack(
          children: [
            _PosterWidget(movie: movie),
            const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.3],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterWidget extends StatelessWidget {
  final Movie movie;

  const _PosterWidget({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.network(
        movie.posterPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) return const SizedBox();
          return FadeIn(child: child);
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
