// lib/features/artwork/domain/usecases/get_artworks_for_quiz.dart

import '../../../../core/use_case/use_case.dart';
import '../entities/artwork.dart';
import '../repositories/artwork_repository.dart';

/// Defines the use case for fetching artworks for the quiz.
/// It retrieves a paginated list of artworks from the repository.
class GetArtworksForQuizUseCase
    extends FutureUseCase<({int limit, int page}), List<Artwork>> {
  GetArtworksForQuizUseCase({required this.artworkRepository});

  final ArtworkRepository artworkRepository;

  @override
  Future<List<Artwork>> unsafeExecute(({int limit, int page}) input) {
    return artworkRepository.getArtworksForQuiz(
      limit: input.limit,
      page: input.page,
    );
  }
}