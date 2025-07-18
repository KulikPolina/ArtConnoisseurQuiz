// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtworkModel _$ArtworkModelFromJson(Map<String, dynamic> json) => ArtworkModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      artistDisplay: json['artist_display'] as String?,
      imageId: json['image_id'] as String?,
      dateDisplay: json['date_display'] as String?,
      styleTitle: json['style_title'] as String?,
    );

Map<String, dynamic> _$ArtworkModelToJson(ArtworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist_display': instance.artistDisplay,
      'image_id': instance.imageId,
      'date_display': instance.dateDisplay,
      'style_title': instance.styleTitle,
    };
