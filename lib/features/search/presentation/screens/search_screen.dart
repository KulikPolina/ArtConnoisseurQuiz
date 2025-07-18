// lib/features/search/presentation/screens/search_screen.dart

import 'package:art_connoisseur_quiz/features/artwork/domain/repositories/artwork_repository.dart';
import 'package:art_connoisseur_quiz/features/artwork/domain/usecases/toggle_favorite_status.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../artwork/domain/entities/artwork.dart';
import '../../../artwork/domain/usecases/search_artworks.dart';
import '../../../artwork/presentation/widgets/artwork_grid_item.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        searchArtworksUseCase: getIt<SearchArtworksUseCase>(),
        toggleFavoriteUseCase: getIt<ToggleFavoriteStatusUseCase>(), // <-- ADD THIS
        artworkRepository: getIt<ArtworkRepository>(), 
      ),
      child: const SearchBody(),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artworks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // The text field for user input.
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search by artist, title, style...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              // The onChanged callback dispatches an event to the BLoC.
              onChanged: (query) {
                context.read<SearchBloc>().add(SearchQueryChanged(query: query));
              },
            ),
            const SizedBox(height: 16),
            // The Expanded widget ensures the results take up the remaining space.
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  // Display a message before any search is performed.
                  if (state is SearchInitial) {
                    return const Center(
                        child: Text('Start typing to search for art.'));
                  }
                  // Show a loading indicator while fetching data.
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Display an error message if the search fails.
                  if (state is SearchError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  // Display the search results in a grid.
                  if (state is SearchSuccess) {
                    if (state.artworks.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7, // Adjusted for the favorite button
                      ),
                      itemCount: state.artworks.length,
                      itemBuilder: (context, index) {
                        final Artwork artwork = state.artworks[index];
                        // Check if the current artwork is in the set of favorites.
                        final bool isFavorite =
                            state.favoriteIds.contains(artwork.id);
                        return ArtworkGridItem(
                          artwork: artwork,
                          isFavorite: isFavorite,
                          // Dispatch an event to toggle the favorite status.
                          onFavoritePressed: () {
                            context
                                .read<SearchBloc>()
                                .add(ToggleFavorite(artworkId: artwork.id));
                          },
                        );
                      },
                    );
                  }
                  // Fallback for any other state.
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}