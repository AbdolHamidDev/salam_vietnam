import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../repositories/mock_cham_articles.dart';

class ChamArticlesScreen extends StatelessWidget {
  const ChamArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Di sản & Văn hóa Chăm')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: MockChamArticlesRepository.articles.length,
        itemBuilder: (context, index) {
          final article = MockChamArticlesRepository.articles[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                context.push('/article/${article.id}');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    article.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      color: AppColors.surfaceSubtle,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.category,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.terracotta,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        Text(article.title, style: AppTypography.titleMedium),
                        const Gap(AppSpacing.xs),
                        Text(
                          article.summary,
                          style: AppTypography.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
