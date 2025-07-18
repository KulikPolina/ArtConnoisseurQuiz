// lib/features/favorites/presentation/bloc/favorites_state.dart

import 'package:equatable/equatable.dart';
import '../../../artwork/domain/entities/artwork.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesInitial extends FavoritesState {} 

class FavoritesSuccess extends FavoritesState {
  const FavoritesSuccess(this.artworks);
  final List<Artwork> artworks;

  @override
  List<Object> get props => [artworks];
}

class FavoritesError extends FavoritesState {
  const FavoritesError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
