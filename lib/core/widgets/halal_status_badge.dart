import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../../shared/models/place.dart';

class HalalStatusBadge extends StatelessWidget {
  final HalalStatus status;
  final bool isCompact;

  const HalalStatusBadge({
    super.key,
    required this.status,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final (color, label, icon) = switch (status) {
      HalalStatus.verified => (
        AppColors.halalVerified,
        l10n?.halalStatusVerified ?? 'Verified Halal',
        Icons.verified_outlined,
      ),
      HalalStatus.selfDeclared => (
        AppColors.halalSelfDeclared,
        l10n?.halalStatusSelfDeclared ?? 'Self-Declared',
        Icons.info_outline,
      ),
      HalalStatus.unverified => (
        AppColors.halalUnverified,
        l10n?.halalStatusUnverified ?? 'Unverified',
        Icons.help_outline,
      ),
      HalalStatus.expired => (
        AppColors.halalExpired,
        l10n?.halalStatusExpired ?? 'Expired',
        Icons.error_outline,
      ),
      HalalStatus.disputed => (
        AppColors.halalDisputed,
        l10n?.halalStatusDisputed ?? 'Disputed',
        Icons.warning_amber_outlined,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? AppSpacing.sm : AppSpacing.md,
        vertical: isCompact ? AppSpacing.xs : AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: AppRadius.borderPill,
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isCompact ? 12 : 14, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: color,
              fontSize: isCompact ? 11 : 12,
            ),
          ),
        ],
      ),
    );
  }
}
