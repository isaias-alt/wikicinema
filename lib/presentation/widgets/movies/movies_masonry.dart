import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wikicinema/domain/entities/movie.dart';
import 'package:wikicinema/presentation/widgets/widgets.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> movie;
  final VoidCallback? loadNextPage;

  const MoviesMasonry({
    super.key,
    required this.movie,
    this.loadNextPage,
  });

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() async {
      final double currentPosition = scrollController.position.pixels + 100;
      final double lastPosition = scrollController.position.maxScrollExtent;
      if (widget.loadNextPage == null) return;
      if (currentPosition >= lastPosition) {
        Future.delayed(const Duration(milliseconds: 200));
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movie.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 20),
                MoviesPosterLink(movies: widget.movie[index]),
              ],
            );
          }
          return MoviesPosterLink(movies: widget.movie[index]);
        },
      ),
    );
  }
}
