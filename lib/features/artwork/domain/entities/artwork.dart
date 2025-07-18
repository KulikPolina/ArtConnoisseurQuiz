import 'package:equatable/equatable.dart';

/// Represents a piece of artwork.
/// This is a pure domain entity, independent of any data source.
class Artwork extends Equatable {
  const Artwork({
    required this.id,
    required this.title,
    required this.artistDisplay,
    required this.imageId,
    this.dateDisplay,
    this.styleTitle,
  });

  final int id;
  final String title;
  final String? artistDisplay;
  final String? imageId;
  final String? dateDisplay;
  final String? styleTitle;

  /// A helper getter to construct the full image URL.
  /// Returns null if imageId is not available.
  String? get imageUrl {
    if (imageId == null) {
      return null;
    }
    return 'https://www.artic.edu/iiif/2/$imageId/full/843,/0/default.jpg';
  }

  @override
  List<Object?> get props => [id, title, artistDisplay, imageId, dateDisplay, styleTitle];
}
