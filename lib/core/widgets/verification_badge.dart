import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../../shared/models/place.dart';

class VerificationBadge extends StatelessWidget {
  final VerificationStatus status;

  const VerificationBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final (color, label) = switch (status) {
      VerificationStatus.fieldVerified => (
        AppColors.fieldVerified,
        l10n?.verificationFieldVerified ?? 'Field Verified',
      ),
      VerificationStatus.sourceConfirmed => (
        AppColors.sourceConfirmed,
        l10n?.verificationSourceConfirmed ?? 'Source Confirmed',
      ),
      VerificationStatus.communityConfirmed => (
        AppColors.communityConfirmed,
        l10n?.verificationCommunityConfirmed ?? 'Community Confirmed',
      ),
      VerificationStatus.unverified => (
        AppColors.textMuted,
        l10n?.verificationUnverified ?? 'Unverified',
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.borderSm,
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
