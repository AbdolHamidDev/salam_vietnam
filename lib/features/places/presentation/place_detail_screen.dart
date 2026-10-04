import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/map_launcher.dart';
import '../../../core/widgets/halal_status_badge.dart';
import '../../../core/widgets/verification_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/models/place.dart';
import '../../../shared/repositories/mock_places.dart';
import '../../favorites/data/favorites_provider.dart';

class PlaceDetailScreen extends ConsumerWidget {
  final String placeId;

  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final place = MockPlacesRepository.samplePlaces.firstWhere(
      (p) => p.id == placeId,
      orElse: () => MockPlacesRepository.samplePlaces.first,
    );

    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.contains(place.id);

    final formattedVerifiedDate = place.lastVerifiedAt != null
        ? DateFormat('dd/MM/yyyy').format(place.lastVerifiedAt!)
        : 'Chưa có thông tin ngày';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {
                  Share.share(
                    'Khám phá ${place.name} tại ${place.address}, ${place.province} trên ứng dụng Salam Vietnam!',
                    subject: place.name,
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.redAccent : Colors.white,
                ),
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(place.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? (l10n?.favoriteRemoved ??
                                  'Removed from saved places')
                            : (l10n?.favoriteAdded ?? 'Added to saved places'),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    place.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceSubtle,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Text(place.name, style: AppTypography.displayLarge),
                  const Gap(AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const Gap(4),
                      Text('${place.rating}', style: AppTypography.titleMedium),
                      Text(
                        ' (${place.reviewCount} đánh giá)',
                        style: AppTypography.bodyMedium,
                      ),
                      const Spacer(),
                      Text(
                        place.province,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.salamGreen,
                        ),
                      ),
                    ],
                  ),

                  const Gap(AppSpacing.lg),

                  // Verification Status Row
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      HalalStatusBadge(status: place.halalStatus),
                      VerificationBadge(status: place.verificationStatus),
                    ],
                  ),

                  // Expired or Disputed Warning Banner
                  if (place.halalStatus == HalalStatus.expired ||
                      place.halalStatus == HalalStatus.disputed) ...[
                    const Gap(AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.halalExpired.withValues(alpha: 0.1),
                        borderRadius: AppRadius.borderMd,
                        border: Border.all(
                          color: AppColors.halalExpired.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.halalExpired,
                          ),
                          const Gap(AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Cảnh báo: Trạng thái Halal của cơ sở này cần được kiểm tra lại hoặc đã hết hạn.',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.halalExpired,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (place.evidenceSummary != null) ...[
                    const Gap(AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSubtle,
                        borderRadius: AppRadius.borderMd,
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.verified_user_outlined,
                                size: 18,
                                color: AppColors.salamGreen,
                              ),
                              const Gap(AppSpacing.sm),
                              Text(
                                'Căn cứ xác minh',
                                style: AppTypography.labelMedium,
                              ),
                              const Spacer(),
                              Text(
                                'Cập nhật: $formattedVerifiedDate',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                          const Gap(AppSpacing.xs),
                          Text(
                            place.evidenceSummary!,
                            style: AppTypography.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],

                  const Gap(AppSpacing.xl),

                  // Description
                  Text('Giới thiệu', style: AppTypography.headlineMedium),
                  const Gap(AppSpacing.sm),
                  Text(
                    place.description,
                    style: AppTypography.bodyMedium.copyWith(height: 1.5),
                  ),

                  const Gap(AppSpacing.xl),

                  // Contact / Address
                  Text(
                    'Địa chỉ & Liên hệ',
                    style: AppTypography.headlineMedium,
                  ),
                  const Gap(AppSpacing.sm),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.location_on,
                              color: AppColors.salamGreen,
                            ),
                            title: Text(place.address),
                            subtitle: Text(place.province),
                          ),
                          if (place.phone != null) ...[
                            const Divider(
                              height: 1,
                              color: AppColors.borderSubtle,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: AppColors.salamGreen,
                              ),
                              title: Text(place.phone!),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const Gap(AppSpacing.lg),

                  // Report Issue Button
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.terracotta,
                      side: const BorderSide(color: AppColors.terracotta),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () {
                      context.push('/submit');
                    },
                    icon: const Icon(Icons.report_problem_outlined, size: 18),
                    label: Text(
                      l10n?.reportIssueTitle ?? 'Report Incorrect Info',
                    ),
                  ),

                  const Gap(AppSpacing.xl),

                  // Directions Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.salamGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.borderLg,
                        ),
                      ),
                      onPressed: () {
                        MapLauncher.launchDirections(
                          latitude: place.latitude ?? 10.7769,
                          longitude: place.longitude ?? 106.7051,
                          placeName: place.name,
                          context: context,
                        );
                      },
                      icon: const Icon(Icons.directions),
                      label: Text(
                        l10n?.directions ?? 'Directions',
                        style: AppTypography.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
