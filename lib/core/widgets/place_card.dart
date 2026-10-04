import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../../shared/models/place.dart';
import '../../features/favorites/data/favorites_provider.dart';
import 'halal_status_badge.dart';

class PlaceCard extends ConsumerWidget {
  final Place place;
  final VoidCallback onTap;

  const PlaceCard({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.contains(place.id);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Badges Stack
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  color: AppColors.surfaceSubtle,
                  child: Image.network(
                    place.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: HalalStatusBadge(
                    status: place.halalStatus,
                    isCompact: true,
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Row(
                    children: [
                      if (place.isSampleData)
                        Container(
                          margin: const EdgeInsets.only(right: AppSpacing.xs),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: AppRadius.borderSm,
                          ),
                          child: const Text(
                            'Dữ liệu mẫu',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(place.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.redAccent : Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: AppTypography.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          '${place.address}, ${place.province}',
                          style: AppTypography.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${place.rating}',
                        style: AppTypography.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' (${place.reviewCount})',
                        style: AppTypography.caption,
                      ),
                      const Spacer(),
                      Text(
                        place.province,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.salamGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
