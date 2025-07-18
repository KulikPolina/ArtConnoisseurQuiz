import '../../../../core/use_case/use_case.dart';
import '../entities/artwork.dart';
import '../repositories/artwork_repository.dart';

class GetCollectedArtworksUseCase extends FutureUseCase<void, List<Artwork>> {
  GetCollectedArtworksUseCase({required this.artworkRepository});
  final ArtworkRepository artworkRepository;

  @override
  Future<List<Artwork>> unsafeExecute(void input) async {
    final List<int> collectedIds = await artworkRepository.getCollectedArtworkIds();
    if (collectedIds.isEmpty) {
      return [];
    }
    return artworkRepository.getArtworksByIds(ids: collectedIds);
  }
}
