// lib/features/search/presentation/bloc/search_event.dart

import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when the user changes the text in the search bar.
class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class ToggleFavorite extends SearchEvent {
  const ToggleFavorite({required this.artworkId});

  final int artworkId;

  @override
  List<Object> get props => [artworkId];
}
