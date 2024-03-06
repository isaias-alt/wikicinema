import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/presentation/delegates/search_movie_delegate.dart';
import 'package:wikicinema/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Image.asset('assets/logo/logo.png', fit: BoxFit.cover),
              
              const SizedBox(width: 5),
              
              Text('Wikicinema', style: TextStyle(color: colors.primary, fontSize: 20)),
              
              const Spacer(),

              IconButton(
                onPressed: () {
                  final searchQuery = ref.read(searchQueryProvider);
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  showSearch(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMoviesDelegate(
                      initialMovies: searchedMovies,
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
