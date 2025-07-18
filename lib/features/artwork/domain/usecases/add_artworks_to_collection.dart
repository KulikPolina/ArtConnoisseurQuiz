import '../../../../core/use_case/use_case.dart';
import '../repositories/artwork_repository.dart';

class AddArtworksToCollectionUseCase extends FutureUseCase<List<int>, void> {
  AddArtworksToCollectionUseCase({required this.artworkRepository});
  final ArtworkRepository artworkRepository;

  @override
  Future<void> unsafeExecute(List<int> artworkIds) {
    return artworkRepository.addArtworksToCollection(artworkIds: artworkIds);
  }
}
