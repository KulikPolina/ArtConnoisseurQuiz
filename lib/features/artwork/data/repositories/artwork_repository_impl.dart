// lib/features/artwork/data/repositories/artwork_repository_impl.dart

import '../../domain/entities/artwork.dart';
import '../../domain/repositories/artwork_repository.dart';
import '../datasources/artwork_local_data_source.dart';
import '../datasources/artwork_remote_data_source.dart';

/// Concrete implementation of the [ArtworkRepository].
/// It coordinates data from the remote and local data sources.
class ArtworkRepositoryImpl implements ArtworkRepository {
  ArtworkRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final ArtworkRemoteDataSource remoteDataSource;
  final ArtworkLocalDataSource localDataSource;

  @override
  Future<List<Artwork>> getArtworksForQuiz(
      {required int limit, required int page}) async {
    final models =
        await remoteDataSource.getArtworksForQuiz(limit: limit, page: page);
    return models.map((model) => model.toDomain()).toList();
  }

  @override
  Future<List<Artwork>> searchArtworks(
      {required String query, required int limit, required int page}) async {
    final models = await remoteDataSource.searchArtworks(
        query: query, limit: limit, page: page);
    return models.map((model) => model.toDomain()).toList();
  }

  @override
  Future<List<Artwork>> getArtworksByIds({required List<int> ids}) async {
    final models = await remoteDataSource.getArtworksByIds(ids: ids);
    return models.map((model) => model.toDomain()).toList();
  }
  
  @override
  Future<List<int>> getFavoriteArtworkIds() {
    return localDataSource.getFavoriteArtworkIds();
  }

  @override
  Future<bool> toggleFavoriteStatus({required int artworkId}) {
    return localDataSource.toggleFavoriteStatus(artworkId: artworkId);
  }

  @override
  Stream<List<int>> getFavoritesStream() {
    return localDataSource.getFavoritesStream();
  }

  @override
  Future<List<int>> getCollectedArtworkIds() {
    return localDataSource.getCollectedArtworkIds();
  }

  @override
  Future<void> addArtworksToCollection({required List<int> artworkIds}) {
    return localDataSource.addArtworksToCollection(artworkIds: artworkIds);
  }
}
