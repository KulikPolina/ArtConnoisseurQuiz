// lib/features/artwork/domain/usecases/get_favorite_artworks.dart

import '../../../../core/use_case/use_case.dart';
import '../entities/artwork.dart';
import '../repositories/artwork_repository.dart';

/// A placeholder for when a use case takes no input.
typedef NoInput = void;

/// Defines the use case for retrieving all favorited artworks.
/// This demonstrates a more complex use case that orchestrates multiple
/// repository calls.
class GetFavoriteArtworksUseCase extends FutureUseCase<NoInput, List<Artwork>> {
  GetFavoriteArtworksUseCase({required this.artworkRepository});

  final ArtworkRepository artworkRepository;

  @override
  Future<List<Artwork>> unsafeExecute(NoInput input) async {
    final List<int> favoriteIds = await artworkRepository.getFavoriteArtworkIds();

    if (favoriteIds.isEmpty) {
      return [];
    }

    return artworkRepository.getArtworksByIds(ids: favoriteIds);
  }
}
