// lib/features/artwork/presentation/widgets/artwork_grid_item.dart

import 'package:flutter/material.dart';
import '../../domain/entities/artwork.dart';

class ArtworkGridItem extends StatelessWidget {
  const ArtworkGridItem({
    super.key,
    required this.artwork,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  final Artwork artwork;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main content column for the image and title
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: artwork.imageUrl != null
                    ? Image.network(
                        artwork.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) =>
                            progress == null
                                ? child
                                : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, color: Colors.grey),
                      )
                    : const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  artwork.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          // Favorite button overlaid on top
          Positioned(
            top: 4,
            right: 4,
            child: Material(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 24,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                ),
                onPressed: onFavoritePressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
