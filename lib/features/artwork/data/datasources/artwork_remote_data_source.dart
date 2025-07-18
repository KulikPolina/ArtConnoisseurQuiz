// lib/features/artwork/data/datasources/artwork_remote_data_source.dart

import 'package:dio/dio.dart';

import '../../../../core/utils/failures.dart';
import '../models/artwork_model.dart';

// API Constants
const String _BASE_URL = 'https://api.artic.edu/api/v1';
const String _ARTWORKS_ENDPOINT = '/artworks';
const String _SEARCH_ENDPOINT = '/artworks/search';
// This string ensures we only get artworks that have an image and all necessary fields.
const String _FIELDS =
    'id,title,image_id,artist_display,date_display,style_title';

/// Abstract interface for the remote data source.
abstract class ArtworkRemoteDataSource {
  Future<List<ArtworkModel>> getArtworksForQuiz({required int limit, required int page});
  Future<List<ArtworkModel>> searchArtworks({required String query, required int limit, required int page});
  Future<List<ArtworkModel>> getArtworksByIds({required List<int> ids});
}

/// Implementation of [ArtworkRemoteDataSource] using the Dio package.
class ArtworkRemoteDataSourceImpl implements ArtworkRemoteDataSource {
  ArtworkRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<ArtworkModel>> getArtworksForQuiz(
      {required int limit, required int page}) async {
    return _fetchArtworksFromApi('$_BASE_URL$_ARTWORKS_ENDPOINT',
        params: {'fields': _FIELDS, 'limit': limit, 'page': page});
  }

  @override
  Future<List<ArtworkModel>> searchArtworks(
      {required String query, required int limit, required int page}) async {
    return _fetchArtworksFromApi('$_BASE_URL$_SEARCH_ENDPOINT', params: {
      'q': query,
      'fields': _FIELDS,
      'limit': limit,
      'page': page
    });
  }

  @override
  Future<List<ArtworkModel>> getArtworksByIds({required List<int> ids}) async {
    final String parsedIds = ids.join(',');
    return _fetchArtworksFromApi('$_BASE_URL$_ARTWORKS_ENDPOINT',
        params: {'ids': parsedIds, 'fields': _FIELDS});
  }
  
  /// A generic helper method to fetch data and handle parsing and errors.
  Future<List<ArtworkModel>> _fetchArtworksFromApi(String url,
      {required Map<String, dynamic> params}) async {
    try {
      final Response<dynamic> response = await dio.get<dynamic>(url, queryParameters: params);

      if (response.statusCode != 200) {
        throw ServerException(message: 'API Error: ${response.statusMessage}', code: response.statusCode);
      }
      
      final List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((dynamic item) => ArtworkModel.fromJson(item as Map<String, dynamic>))
          .toList();
          
    } on DioException catch (e) {
      // Re-throw a domain-specific exception
      throw ServerException(message: e.message ?? 'A network error occurred');
    } catch (e) {
      throw ServerException(message: 'An unexpected error occurred: $e');
    }
  }
}
