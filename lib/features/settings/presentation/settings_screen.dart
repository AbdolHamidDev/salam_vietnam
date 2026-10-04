import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.navSettings ?? 'Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Language Setting Section
          Text(
            l10n?.language ?? 'Language',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(AppSpacing.sm),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Text('🇻🇳', style: TextStyle(fontSize: 20)),
                  title: Text(l10n?.vietnamese ?? 'Tiếng Việt'),
                  trailing: currentLocale.languageCode == 'vi'
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.salamGreen,
                        )
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguageCode('vi');
                  },
                ),
                const Divider(height: 1, color: AppColors.borderSubtle),
                ListTile(
                  leading: const Text('🇬🇧', style: TextStyle(fontSize: 20)),
                  title: Text(l10n?.english ?? 'English'),
                  trailing: currentLocale.languageCode == 'en'
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.salamGreen,
                        )
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguageCode('en');
                  },
                ),
                const Divider(height: 1, color: AppColors.borderSubtle),
                ListTile(
                  leading: const Text('🇲🇾', style: TextStyle(fontSize: 20)),
                  title: Text(l10n?.malay ?? 'Bahasa Melayu'),
                  trailing: currentLocale.languageCode == 'ms'
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.salamGreen,
                        )
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguageCode('ms');
                  },
                ),
              ],
            ),
          ),

          const Gap(AppSpacing.xl),

          // Moderator Section
          Text(
            'Ban quản trị (Moderation)',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(AppSpacing.sm),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.published_with_changes,
                color: AppColors.salamGreen,
              ),
              title: const Text('Hàng chờ kiểm duyệt địa điểm'),
              subtitle: const Text(
                'Duyệt các đề xuất đóng góp mới từ cộng đồng',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push('/moderator');
              },
            ),
          ),

          const Gap(AppSpacing.xl),

          // About Section
          Text(
            l10n?.settingsAbout ?? 'About Salam Vietnam',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(AppSpacing.sm),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: AppColors.salamGreen,
              ),
              title: const Text('Salam Vietnam'),
              subtitle: Text(l10n?.settingsVersion ?? 'Version 1.0.0 (MVP)'),
            ),
          ),
        ],
      ),
    );
  }
}
