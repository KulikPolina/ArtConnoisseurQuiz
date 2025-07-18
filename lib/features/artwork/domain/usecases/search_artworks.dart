// lib/features/artwork/domain/usecases/search_artworks.dart

import '../../../../core/use_case/use_case.dart';
import '../entities/artwork.dart';
import '../repositories/artwork_repository.dart';

/// Defines the use case for searching artworks.
/// It takes a search query and pagination parameters.
class SearchArtworksUseCase
    extends FutureUseCase<({String query, int limit, int page}), List<Artwork>> {
  SearchArtworksUseCase({required this.artworkRepository});

  final ArtworkRepository artworkRepository;

  @override
  Future<List<Artwork>> unsafeExecute(
      ({String query, int limit, int page}) input) {
    return artworkRepository.searchArtworks(
      query: input.query,
      limit: input.limit,
      page: input.page,
    );
  }
}
