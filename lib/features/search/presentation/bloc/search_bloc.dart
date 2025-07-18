import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../artwork/domain/repositories/artwork_repository.dart';
import '../../../artwork/domain/usecases/search_artworks.dart';
import '../../../artwork/domain/usecases/toggle_favorite_status.dart';
import 'search_event.dart';
import 'search_state.dart';

const _duration = Duration(milliseconds: 300);

class _FavoritesUpdated extends SearchEvent {
  const _FavoritesUpdated(this.favoriteIds);
  final Set<int> favoriteIds;
}

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.searchArtworksUseCase,
    required this.toggleFavoriteUseCase,
    required ArtworkRepository artworkRepository,
  }) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged, transformer: debounce(_duration));
    on<ToggleFavorite>(_onToggleFavorite);
    on<_FavoritesUpdated>(_onFavoritesUpdated);

    // FIX: Remove the incorrect cast `as StreamSubscription<Set<int>>`
    _favoritesSubscription = artworkRepository.getFavoritesStream().listen(
          (ids) => add(_FavoritesUpdated(ids.toSet())),
        );
  }

  final SearchArtworksUseCase searchArtworksUseCase;
  final ToggleFavoriteStatusUseCase toggleFavoriteUseCase;
  // FIX: Change the type from Set<int> to List<int> to match the stream
  late final StreamSubscription<List<int>> _favoritesSubscription;

  @override
  Future<void> close() {
    _favoritesSubscription.cancel();
    return super.close();
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final results = await searchArtworksUseCase.execute(
        (query: query, limit: 20, page: 1),
      );

      final currentFavorites = state is SearchSuccess ? (state as SearchSuccess).favoriteIds : <int>{};
      emit(SearchSuccess(artworks: results, favoriteIds: currentFavorites));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<SearchState> emit,
  ) async {
    await toggleFavoriteUseCase.execute(event.artworkId);
  }

  void _onFavoritesUpdated(
    _FavoritesUpdated event,
    Emitter<SearchState> emit,
  ) {
    if (state is SearchSuccess) {
      final currentState = state as SearchSuccess;
      emit(currentState.copyWith(favoriteIds: event.favoriteIds));
    }
  }
}