import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/models/place.dart';
import '../data/search_filter_provider.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  static const List<String> provinces = [
    'Tất cả',
    'TP. Hồ Chí Minh',
    'Hà Nội',
    'Ninh Thuận',
    'Đà Nẵng',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selectedProvince = ref.watch(selectedProvinceProvider) ?? 'Tất cả';
    final selectedHalalStatus = ref.watch(selectedHalalStatusFilterProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n?.filterTitle ?? 'Search Filters',
                style: AppTypography.headlineMedium,
              ),
              TextButton(
                onPressed: () {
                  ref.read(selectedProvinceProvider.notifier).state = null;
                  ref.read(selectedHalalStatusFilterProvider.notifier).state =
                      null;
                },
                child: Text(
                  l10n?.filterReset ?? 'Reset',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.terracotta,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.borderSubtle),
          const Gap(AppSpacing.md),

          // Province Filter Section
          Text(
            l10n?.filterProvince ?? 'Province / City',
            style: AppTypography.titleMedium,
          ),
          const Gap(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: provinces.map((p) {
              final isSelected = selectedProvince == p;
              return ChoiceChip(
                label: Text(p),
                selected: isSelected,
                selectedColor: AppColors.salamGreen,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (selected) {
                  ref.read(selectedProvinceProvider.notifier).state = selected
                      ? p
                      : null;
                },
              );
            }).toList(),
          ),

          const Gap(AppSpacing.lg),

          // Halal Status Filter Section
          Text(
            l10n?.filterHalalStatus ?? 'Halal Status',
            style: AppTypography.titleMedium,
          ),
          const Gap(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ChoiceChip(
                label: Text(l10n?.halalStatusVerified ?? 'Verified Halal'),
                selected: selectedHalalStatus == HalalStatus.verified,
                selectedColor: AppColors.halalVerified,
                labelStyle: TextStyle(
                  color: selectedHalalStatus == HalalStatus.verified
                      ? Colors.white
                      : AppColors.textPrimary,
                ),
                onSelected: (selected) {
                  ref.read(selectedHalalStatusFilterProvider.notifier).state =
                      selected ? HalalStatus.verified : null;
                },
              ),
              ChoiceChip(
                label: Text(l10n?.halalStatusSelfDeclared ?? 'Self-Declared'),
                selected: selectedHalalStatus == HalalStatus.selfDeclared,
                selectedColor: AppColors.halalSelfDeclared,
                labelStyle: TextStyle(
                  color: selectedHalalStatus == HalalStatus.selfDeclared
                      ? Colors.white
                      : AppColors.textPrimary,
                ),
                onSelected: (selected) {
                  ref.read(selectedHalalStatusFilterProvider.notifier).state =
                      selected ? HalalStatus.selfDeclared : null;
                },
              ),
            ],
          ),

          const Gap(AppSpacing.xl),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.salamGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n?.filterApply ?? 'Apply Filters',
                style: AppTypography.titleMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
          const Gap(AppSpacing.md),
        ],
      ),
    );
  }
}
