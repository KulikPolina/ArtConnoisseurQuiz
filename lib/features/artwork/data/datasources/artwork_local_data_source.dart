// lib/features/artwork/data/datasources/artwork_local_data_source.dart

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const String _kFavoritesKey = 'favorite_artworks';
const String _kCollectionKey = 'collection_artworks';

/// Abstract interface for the local data source.
abstract class ArtworkLocalDataSource {
  Stream<List<int>> getFavoritesStream();
  Future<List<int>> getFavoriteArtworkIds();
  Future<bool> toggleFavoriteStatus({required int artworkId});
  Future<List<int>> getCollectedArtworkIds();
  Future<void> addArtworksToCollection({required List<int> artworkIds});
  void dispose();
}

/// Implementation of [ArtworkLocalDataSource] using SharedPreferences.
class ArtworkLocalDataSourceImpl implements ArtworkLocalDataSource {
  ArtworkLocalDataSourceImpl({required this.sharedPreferences}) {
    // When the data source is created, immediately push the current list
    // of favorites to the stream.
    getFavoriteArtworkIds().then((ids) => _favoritesStreamController.add(ids));
  }

  final SharedPreferences sharedPreferences;
  final _favoritesStreamController = StreamController<List<int>>.broadcast();
  
  @override
  Stream<List<int>> getFavoritesStream() => _favoritesStreamController.stream;

  @override
  Future<List<int>> getFavoriteArtworkIds() async {
    final List<String> favoriteIds =
        sharedPreferences.getStringList(_kFavoritesKey) ?? [];
    return favoriteIds.map(int.parse).toList();
  }

  @override
  Future<bool> toggleFavoriteStatus({required int artworkId}) async {
    final List<String> favoriteIds =
        sharedPreferences.getStringList(_kFavoritesKey) ?? [];
    final String idAsString = artworkId.toString();
    bool isNowFavorite;

    if (favoriteIds.contains(idAsString)) {
      favoriteIds.remove(idAsString);
      isNowFavorite = false;
    } else {
      favoriteIds.add(idAsString);
      isNowFavorite = true;
    }

    await sharedPreferences.setStringList(_kFavoritesKey, favoriteIds);
    // Push the updated list to the stream
    _favoritesStreamController.add(favoriteIds.map(int.parse).toList());

    return isNowFavorite;
  }

  @override
  Future<List<int>> getCollectedArtworkIds() async {
    final List<String> collectedIds =
        sharedPreferences.getStringList(_kCollectionKey) ?? [];
    return collectedIds.map(int.parse).toList();
  }

  @override
  Future<void> addArtworksToCollection({required List<int> artworkIds}) async {
    final List<String> existingIds =
        sharedPreferences.getStringList(_kCollectionKey) ?? [];
    
    // Use a Set to avoid duplicates
    final Set<String> newIdSet = {...existingIds, ...artworkIds.map((id) => id.toString())};
    
    await sharedPreferences.setStringList(_kCollectionKey, newIdSet.toList());
  }

  @override
  void dispose() {
    _favoritesStreamController.close();
  }
}
