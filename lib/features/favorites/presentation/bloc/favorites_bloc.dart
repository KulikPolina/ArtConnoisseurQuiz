// lib/features/favorites/presentation/bloc/favorites_bloc.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../artwork/domain/repositories/artwork_repository.dart';
import '../../../artwork/domain/usecases/get_favorite_artworks.dart';
import '../../../artwork/domain/usecases/toggle_favorite_status.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.getFavoriteArtworksUseCase,
    required this.toggleFavoriteUseCase,
    required ArtworkRepository artworkRepository,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<FavoritesUpdated>(_onFavoritesUpdated);

    // Subscribe to the stream of favorite ID changes
    _favoritesSubscription = artworkRepository.getFavoritesStream().listen(
          (ids) => add(FavoritesUpdated(ids)),
        );
  }

  final GetFavoriteArtworksUseCase getFavoriteArtworksUseCase;
  late final StreamSubscription<List<int>> _favoritesSubscription;
  final ToggleFavoriteStatusUseCase toggleFavoriteUseCase;

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final artworks = await getFavoriteArtworksUseCase.execute(null);
      emit(FavoritesSuccess(artworks));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    // When the user unfavorites an item, we just call the use case.
    // The reactive stream will automatically trigger an update.
    await toggleFavoriteUseCase.execute(event.artworkId);
  }

  Future<void> _onFavoritesUpdated(
    FavoritesUpdated event,
    Emitter<FavoritesState> emit,
  ) async {
    // When the IDs change, just re-run the main logic to get full artworks.
    await _onLoadFavorites(LoadFavorites(), emit);
  }

  @override
  Future<void> close() {
    _favoritesSubscription.cancel();
    return super.close();
  }
}
