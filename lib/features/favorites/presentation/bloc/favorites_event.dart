// lib/features/favorites/presentation/bloc/favorites_event.dart

import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object> get props => [];
}

/// Event to explicitly request a reload of favorites.
class LoadFavorites extends FavoritesEvent {}

/// Internal event triggered by the stream when the favorite list changes.
class FavoritesUpdated extends FavoritesEvent {
  const FavoritesUpdated(this.artworkIds);
  final List<int> artworkIds;

  @override
  List<Object> get props => [artworkIds];
}

class ToggleFavorite extends FavoritesEvent {
  const ToggleFavorite({required this.artworkId});

  final int artworkId;

  @override
  List<Object> get props => [artworkId];
}

