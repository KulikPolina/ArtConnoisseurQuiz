// lib/features/favorites/presentation/screens/favorites_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../../../../core/theme/theme_event.dart';
import '../../../artwork/domain/entities/artwork.dart';
import '../../../artwork/domain/repositories/artwork_repository.dart';
import '../../../artwork/domain/usecases/get_favorite_artworks.dart';
import '../../../artwork/domain/usecases/toggle_favorite_status.dart';
import '../../../artwork/presentation/widgets/artwork_grid_item.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        getFavoriteArtworksUseCase: getIt<GetFavoriteArtworksUseCase>(),
        artworkRepository: getIt<ArtworkRepository>(),
        toggleFavoriteUseCase: getIt<ToggleFavoriteStatusUseCase>(),
      )..add(LoadFavorites()),
      child: const FavoritesBody(),
    );
  }
}

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap with a BlocBuilder to get the current theme from ThemeBloc
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Favorites'),
            // Add the actions list for our button
            actions: [
              IconButton(
                // Set the icon based on the current theme
                icon: Icon(
                  themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                ),
                // When pressed, dispatch an event to the ThemeBloc
                onPressed: () {
                  context.read<ThemeBloc>().add(ThemeToggled());
                },
              ),
            ],
          ),
          // This second BlocBuilder handles the state for the favorites list
          body: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is FavoritesError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is FavoritesSuccess) {
                if (state.artworks.isEmpty) {
                  return const Center(
                    child: Text('You have no favorite artworks yet.'),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.artworks.length,
                  itemBuilder: (context, index) {
                    final Artwork artwork = state.artworks[index];
                    return ArtworkGridItem(
                      artwork: artwork,
                      isFavorite: true,
                      onFavoritePressed: () {
                        context
                            .read<FavoritesBloc>()
                            .add(ToggleFavorite(artworkId: artwork.id));
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
