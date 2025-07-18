// lib/features/artwork/domain/usecases/toggle_favorite_status.dart

import '../../../../core/use_case/use_case.dart';
import '../repositories/artwork_repository.dart';

/// Defines the use case for toggling the favorite status of an artwork.
/// It takes an artwork ID as input and returns a boolean indicating
/// the new favorite state (true if favorited, false otherwise).
class ToggleFavoriteStatusUseCase extends FutureUseCase<int, bool> {
  ToggleFavoriteStatusUseCase({required this.artworkRepository});

  final ArtworkRepository artworkRepository;

  @override
  Future<bool> unsafeExecute(int artworkId) {
    return artworkRepository.toggleFavoriteStatus(artworkId: artworkId);
  }
}
