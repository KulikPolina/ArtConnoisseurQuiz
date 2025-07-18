// lib/features/artwork/data/models/artwork_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/artwork.dart';

part 'artwork_model.g.dart';

/// Data Transfer Object (DTO) for an artwork from the API.
/// This class is responsible for parsing the JSON response.
@JsonSerializable()
class ArtworkModel {
  const ArtworkModel({
    required this.id,
    required this.title,
    this.artistDisplay,
    this.imageId,
    this.dateDisplay,
    this.styleTitle,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) =>
      _$ArtworkModelFromJson(json);

  final int id;
  final String title;
  @JsonKey(name: 'artist_display')
  final String? artistDisplay;
  @JsonKey(name: 'image_id')
  final String? imageId;
  @JsonKey(name: 'date_display')
  final String? dateDisplay;
  @JsonKey(name: 'style_title')
  final String? styleTitle;


  Map<String, dynamic> toJson() => _$ArtworkModelToJson(this);

  /// Maps the data layer [ArtworkModel] to the domain layer [Artwork] entity.
  Artwork toDomain() {
    return Artwork(
      id: id,
      title: title,
      artistDisplay: artistDisplay,
      imageId: imageId,
      dateDisplay: dateDisplay,
      styleTitle: styleTitle,
    );
  }
}