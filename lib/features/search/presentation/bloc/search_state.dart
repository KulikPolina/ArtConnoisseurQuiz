// lib/features/search/presentation/bloc/search_state.dart

import 'package:equatable/equatable.dart';
import '../../../artwork/domain/entities/artwork.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

/// The initial state, before any search has been performed.
class SearchInitial extends SearchState {}

/// The state when a search is in progress.
class SearchLoading extends SearchState {}

/// The state when a search has failed.
class SearchError extends SearchState {
  const SearchError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class SearchSuccess extends SearchState {
  const SearchSuccess({
    required this.artworks,
    required this.favoriteIds,
  });

  final List<Artwork> artworks;
  final Set<int> favoriteIds; // <-- ADD THIS

  @override
  List<Object> get props => [artworks, favoriteIds]; // <-- ADD TO PROPS

  SearchSuccess copyWith({
    List<Artwork>? artworks,
    Set<int>? favoriteIds,
  }) {
    return SearchSuccess(
      artworks: artworks ?? this.artworks,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

