import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:wikicinema/domain/entities/movie.dart';

import '../widgets/movies/movie_search_items.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMoviesDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar películas');

  void _onQueryChance(String query) {
    if (_debounceTimer?.isActive ?? false) return _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
    });
  }

  void _clearStreams() {
    debouncedMovies.close();
  }

  Widget buidResultsAndSuggestions() {
    return StreamBuilder(
      stream: debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () => context.push('/home/0/movie/${movie.id}'),
              child: MovieSearchItems(
                movie: movie,
                onMovieSelected: (context, movie) {
                  _clearStreams();
                  close(context, movie);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buidResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChance(query);

    return buidResultsAndSuggestions();
  }
}
