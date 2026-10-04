import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/category_chip.dart';
import '../../../core/widgets/place_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/models/place.dart';
import '../../search/data/search_filter_provider.dart';
import '../../search/presentation/filter_bottom_sheet.dart';
import '../data/places_provider.dart';

final selectedCategoryProvider = StateProvider<PlaceCategory>(
  (ref) => PlaceCategory.all,
);

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final currentLocale = ref.watch(localeProvider);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n?.selectLanguage ?? 'Select Language',
                  style: AppTypography.headlineMedium,
                ),
                const Gap(AppSpacing.md),
                ListTile(
                  leading: const Text('🇻🇳', style: TextStyle(fontSize: 24)),
                  title: Text(l10n?.vietnamese ?? 'Tiếng Việt'),
                  trailing: currentLocale.languageCode == 'vi'
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.salamGreen,
                        )
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguageCode('vi');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                  title: Text(l10n?.english ?? 'English'),
                  trailing: currentLocale.languageCode == 'en'
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.salamGreen,
                        )
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguageCode('en');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Text('🇲🇾', style: TextStyle(fontSize: 24)),
                  title: Text(l10n?.malay ?? 'Bahasa Melayu'),
                  trailing: currentLocale.languageCode == 'ms'
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.salamGreen,
                        )
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguageCode('ms');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final currentLocale = ref.watch(localeProvider);
    final filteredPlacesAsync = ref.watch(filteredPlacesAsyncProvider);

    final langFlag = switch (currentLocale.languageCode) {
      'en' => '🇬🇧',
      'ms' => '🇲🇾',
      _ => '🇻🇳',
    };

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.salamGreen.withValues(alpha: 0.1),
                borderRadius: AppRadius.borderSm,
              ),
              child: const Icon(
                Icons.explore,
                color: AppColors.salamGreen,
                size: 20,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(l10n?.appTitle ?? 'Salam Vietnam'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_location_alt_outlined,
              color: AppColors.salamGreen,
            ),
            tooltip: l10n?.submitPlaceTitle ?? 'Contribute',
            onPressed: () {
              context.push('/submit');
            },
          ),
          TextButton.icon(
            onPressed: () => _showLanguageSelector(context, ref),
            icon: Text(langFlag, style: const TextStyle(fontSize: 18)),
            label: Text(
              currentLocale.languageCode.toUpperCase(),
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.salamGreen,
              ),
            ),
          ),
          const Gap(AppSpacing.xs),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppSpacing.md),

                // Search Input Field & Filter Button
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          ref.read(searchQueryProvider.notifier).state = val;
                        },
                        decoration: InputDecoration(
                          hintText: l10n?.searchPlaceholder ?? 'Search...',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.textMuted,
                          ),
                          filled: true,
                          fillColor: AppColors.surfaceLight,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.borderLg,
                            borderSide: const BorderSide(
                              color: AppColors.borderSubtle,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: AppRadius.borderLg,
                            borderSide: const BorderSide(
                              color: AppColors.borderSubtle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const FilterBottomSheet(),
                        );
                      },
                      borderRadius: AppRadius.borderLg,
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.salamGreen,
                          borderRadius: AppRadius.borderLg,
                        ),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(AppSpacing.md),

                // Sample Data Notice
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warmSand.withValues(alpha: 0.15),
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(
                      color: AppColors.warmSand.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppColors.terracotta,
                      ),
                      const Gap(AppSpacing.sm),
                      Expanded(
                        child: Text(
                          l10n?.sampleDataNotice ??
                              'Sample data for UI demonstration',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(AppSpacing.lg),

                // Category Shortcuts
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryChip(
                        category: PlaceCategory.all,
                        label: l10n?.categoryAll ?? 'All',
                        icon: Icons.apps,
                        isSelected: selectedCategory == PlaceCategory.all,
                        onTap: () =>
                            ref.read(selectedCategoryProvider.notifier).state =
                                PlaceCategory.all,
                      ),
                      const Gap(AppSpacing.sm),
                      CategoryChip(
                        category: PlaceCategory.halalFood,
                        label: l10n?.categoryHalalFood ?? 'Halal Food',
                        icon: Icons.restaurant,
                        isSelected: selectedCategory == PlaceCategory.halalFood,
                        onTap: () =>
                            ref.read(selectedCategoryProvider.notifier).state =
                                PlaceCategory.halalFood,
                      ),
                      const Gap(AppSpacing.sm),
                      CategoryChip(
                        category: PlaceCategory.mosque,
                        label: l10n?.categoryMosque ?? 'Mosques',
                        icon: Icons.account_balance,
                        isSelected: selectedCategory == PlaceCategory.mosque,
                        onTap: () =>
                            ref.read(selectedCategoryProvider.notifier).state =
                                PlaceCategory.mosque,
                      ),
                      const Gap(AppSpacing.sm),
                      CategoryChip(
                        category: PlaceCategory.chamCulture,
                        label: l10n?.categoryChamCulture ?? 'Cham Culture',
                        icon: Icons.museum,
                        isSelected:
                            selectedCategory == PlaceCategory.chamCulture,
                        onTap: () =>
                            ref.read(selectedCategoryProvider.notifier).state =
                                PlaceCategory.chamCulture,
                      ),
                      const Gap(AppSpacing.sm),
                      CategoryChip(
                        category: PlaceCategory.accommodation,
                        label: l10n?.categoryAccommodation ?? 'Accommodation',
                        icon: Icons.hotel,
                        isSelected:
                            selectedCategory == PlaceCategory.accommodation,
                        onTap: () =>
                            ref.read(selectedCategoryProvider.notifier).state =
                                PlaceCategory.accommodation,
                      ),
                    ],
                  ),
                ),

                const Gap(AppSpacing.xl),

                // Cham Culture Highlight Banner
                Card(
                  color: AppColors.salamGreen,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_stories,
                          color: AppColors.softGold,
                          size: 36,
                        ),
                        const Gap(AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n?.sectionChamHighlights ??
                                    'Cham Cultural Heritage',
                                style: AppTypography.titleMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(2),
                              Text(
                                'Khám phá lịch sử, tháp cổ & di sản gốm Bàu Trúc',
                                style: AppTypography.caption.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context.push('/cham-articles');
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(AppSpacing.xl),

                // Section Header & Places Async Value
                filteredPlacesAsync.when(
                  data: (filteredPlaces) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n?.sectionFeatured ?? 'Featured Places',
                              style: AppTypography.headlineMedium,
                            ),
                            Text(
                              '${filteredPlaces.length} địa điểm',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                        const Gap(AppSpacing.sm),
                        if (filteredPlaces.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.xxl),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: AppColors.textMuted,
                                ),
                                const Gap(AppSpacing.md),
                                Text(
                                  'Không tìm thấy địa điểm nào phù hợp',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredPlaces.length,
                            itemBuilder: (context, index) {
                              final place = filteredPlaces[index];
                              return PlaceCard(
                                place: place,
                                onTap: () {
                                  context.push('/place/${place.id}');
                                },
                              );
                            },
                          ),
                      ],
                    );
                  },
                  loading: () => Container(
                    padding: const EdgeInsets.all(AppSpacing.xxl),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: AppColors.salamGreen,
                    ),
                  ),
                  error: (error, stack) => Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: AppColors.terracotta,
                        ),
                        const Gap(AppSpacing.md),
                        Text(
                          'Đã xảy ra lỗi khi tải dữ liệu',
                          style: AppTypography.titleMedium,
                        ),
                        const Gap(AppSpacing.sm),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.salamGreen,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            ref.invalidate(allPlacesProvider);
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
