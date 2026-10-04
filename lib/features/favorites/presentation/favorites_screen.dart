import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/place_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/repositories/mock_places.dart';
import '../data/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final favoriteIds = ref.watch(favoritesProvider);

    final savedPlaces = MockPlacesRepository.samplePlaces
        .where((p) => favoriteIds.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.navSaved ?? 'Saved')),
      body: savedPlaces.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: AppColors.warmSand.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border_rounded,
                        size: 64,
                        color: AppColors.terracotta,
                      ),
                    ),
                    const Gap(AppSpacing.lg),
                    Text(
                      l10n?.savedPlacesEmpty ?? 'No saved places yet',
                      style: AppTypography.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(AppSpacing.sm),
                    const Text(
                      'Lưu các nhà hàng, Thánh đường hoặc địa điểm văn hóa yêu thích để truy cập nhanh chóng.',
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: savedPlaces.length,
              itemBuilder: (context, index) {
                final place = savedPlaces[index];
                return PlaceCard(
                  place: place,
                  onTap: () {
                    context.push('/place/${place.id}');
                  },
                );
              },
            ),
    );
  }
}
