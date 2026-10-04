import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../repositories/mock_cham_articles.dart';

class ChamArticleDetailScreen extends StatelessWidget {
  final String articleId;

  const ChamArticleDetailScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final article = MockChamArticlesRepository.articles.firstWhere(
      (a) => a.id == articleId,
      orElse: () => MockChamArticlesRepository.articles.first,
    );

    return Scaffold(
      appBar: AppBar(title: Text(article.category)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title, style: AppTypography.displayLarge),
            const Gap(AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const Gap(4),
                Text(
                  article.authorName,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.md),
            ClipRRect(
              borderRadius: AppRadius.borderLg,
              child: Image.network(
                article.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: AppColors.surfaceSubtle,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                  ),
                ),
              ),
            ),
            const Gap(AppSpacing.lg),
            Text(
              article.summary,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.salamGreen,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Gap(AppSpacing.md),
            const Divider(color: AppColors.borderSubtle),
            const Gap(AppSpacing.md),
            Text(
              article.bodyContent,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.6,
                fontSize: 15,
              ),
            ),
            const Gap(AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.warmSand.withValues(alpha: 0.15),
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: AppColors.warmSand.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_stories,
                    color: AppColors.terracotta,
                    size: 20,
                  ),
                  const Gap(AppSpacing.sm),
                  Expanded(
                    child: Text(
                      article.sourceAttribution,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
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
