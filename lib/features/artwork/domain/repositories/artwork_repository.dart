import '../entities/artwork.dart';

/// Abstract repository defining the contract for artwork data operations.
/// The domain layer depends on this abstraction, while the data layer
/// provides its concrete implementation.
abstract class ArtworkRepository {
  /// Fetches a list of artworks suitable for a quiz.
  Future<List<Artwork>> getArtworksForQuiz({
    required int limit,
    required int page,
  });

  /// Searches for artworks based on a query.
  Future<List<Artwork>> searchArtworks({
    required String query,
    required int limit,
    required int page,
  });

  /// Retrieves a list of all favorited artwork IDs from local storage.
  Future<List<int>> getFavoriteArtworkIds();

  /// Fetches artwork details for a list of IDs.
  Future<List<Artwork>> getArtworksByIds({
    required List<int> ids,
  });

  /// Toggles the favorite status of an artwork.
  /// Returns true if the artwork is now a favorite, false otherwise.
  Future<bool> toggleFavoriteStatus({
    required int artworkId,
  });

  Stream<List<int>> getFavoritesStream();

  Future<List<int>> getCollectedArtworkIds();
  Future<void> addArtworksToCollection({required List<int> artworkIds});
}
