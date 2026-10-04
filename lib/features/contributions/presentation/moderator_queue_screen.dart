import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../data/submissions_provider.dart';

class ModeratorQueueScreen extends ConsumerWidget {
  const ModeratorQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submissions = ref.watch(submissionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hàng chờ kiểm duyệt (Moderator)')),
      body: SafeArea(
        child: submissions.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.published_with_changes,
                        size: 64,
                        color: AppColors.salamGreen,
                      ),
                      const Gap(AppSpacing.lg),
                      Text(
                        'Không có đề xuất nào đang chờ',
                        style: AppTypography.titleLarge,
                      ),
                      const Gap(AppSpacing.sm),
                      const Text(
                        'Tất cả các đóng góp địa điểm và báo cáo thông tin từ cộng đồng đã được kiểm duyệt.',
                        style: AppTypography.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: submissions.length,
                itemBuilder: (context, index) {
                  final item = submissions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: item.status == 'pending'
                                      ? AppColors.halalSelfDeclared.withValues(
                                          alpha: 0.2,
                                        )
                                      : AppColors.salamGreen.withValues(
                                          alpha: 0.2,
                                        ),
                                  borderRadius: AppRadius.borderSm,
                                ),
                                child: Text(
                                  item.status.toUpperCase(),
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                          const Gap(AppSpacing.xs),
                          Text(item.name, style: AppTypography.titleMedium),
                          const Gap(2),
                          Text(
                            '${item.address}, ${item.province}',
                            style: AppTypography.bodyMedium,
                          ),
                          if (item.phone != null && item.phone!.isNotEmpty) ...[
                            const Gap(2),
                            Text(
                              'SĐT: ${item.phone}',
                              style: AppTypography.caption,
                            ),
                          ],
                          if (item.notes != null && item.notes!.isNotEmpty) ...[
                            const Gap(AppSpacing.xs),
                            Text(
                              'Ghi chú: ${item.notes}',
                              style: AppTypography.bodyMedium,
                            ),
                          ],
                          const Gap(AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.terracotta,
                                  side: const BorderSide(
                                    color: AppColors.terracotta,
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Từ chối đóng góp: ${item.name}',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Từ chối'),
                              ),
                              const Gap(AppSpacing.sm),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.salamGreen,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Đã duyệt và xuất bản: ${item.name}',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Duyệt xuất bản'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
