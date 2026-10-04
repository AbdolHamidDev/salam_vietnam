import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../data/submissions_provider.dart';

class SubmitPlaceScreen extends ConsumerStatefulWidget {
  const SubmitPlaceScreen({super.key});

  @override
  ConsumerState<SubmitPlaceScreen> createState() => _SubmitPlaceScreenState();
}

class _SubmitPlaceScreenState extends ConsumerState<SubmitPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedCategory = 'halal_food';
  String _selectedProvince = 'TP. Hồ Chí Minh';

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final l10n = AppLocalizations.of(context);
      final submission = PlaceSubmission(
        id: 'sub_${DateTime.now().millisecondsSinceEpoch}',
        submissionType: 'new_place',
        name: _nameController.text.trim(),
        category: _selectedCategory,
        address: _addressController.text.trim(),
        province: _selectedProvince,
        phone: _phoneController.text.trim(),
        notes: _notesController.text.trim(),
        status: 'pending',
      );

      ref.read(submissionsProvider.notifier).addSubmission(submission);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
          title: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.salamGreen,
              ),
              const Gap(AppSpacing.sm),
              Text(l10n?.submitSuccessTitle ?? 'Submission Received'),
            ],
          ),
          content: Text(
            l10n?.submitSuccessMessage ??
                'Thank you! Your submission is pending review by a moderator.',
            style: AppTypography.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to previous screen
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: AppColors.salamGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.submitPlaceTitle ?? 'Contribute a Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n?.submitPlaceSubtitle ?? 'Submit Halal venue or Cham heritage site for moderator review',
                style: AppTypography.bodyMedium,
              ),
              const Gap(AppSpacing.lg),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n?.submitFormName ?? 'Place Name',
                  border: OutlineInputBorder(borderRadius: AppRadius.borderMd),
                ),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Vui lòng nhập tên địa điểm'
                    : null,
              ),
              const Gap(AppSpacing.md),

              // Category Field
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: l10n?.submitFormCategory ?? 'Category',
                  border: OutlineInputBorder(borderRadius: AppRadius.borderMd),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'halal_food',
                    child: Text(l10n?.categoryHalalFood ?? 'Halal Food'),
                  ),
                  DropdownMenuItem(
                    value: 'mosque',
                    child: Text(l10n?.categoryMosque ?? 'Mosques'),
                  ),
                  DropdownMenuItem(
                    value: 'cham_culture',
                    child: Text(l10n?.categoryChamCulture ?? 'Cham Culture'),
                  ),
                  DropdownMenuItem(
                    value: 'accommodation',
                    child: Text(l10n?.categoryAccommodation ?? 'Accommodation'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
              const Gap(AppSpacing.md),

              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: l10n?.submitFormAddress ?? 'Address',
                  border: OutlineInputBorder(borderRadius: AppRadius.borderMd),
                ),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Vui lòng nhập địa chỉ'
                    : null,
              ),
              const Gap(AppSpacing.md),

              // Province Field
              DropdownButtonFormField<String>(
                initialValue: _selectedProvince,
                decoration: InputDecoration(
                  labelText: l10n?.submitFormProvince ?? 'Province / City',
                  border: OutlineInputBorder(borderRadius: AppRadius.borderMd),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'TP. Hồ Chí Minh',
                    child: Text('TP. Hồ Chí Minh'),
                  ),
                  DropdownMenuItem(value: 'Hà Nội', child: Text('Hà Nội')),
                  DropdownMenuItem(
                    value: 'Ninh Thuận',
                    child: Text('Ninh Thuận'),
                  ),
                  DropdownMenuItem(value: 'Đà Nẵng', child: Text('Đà Nẵng')),
                  DropdownMenuItem(value: 'Khác', child: Text('Khác')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedProvince = val);
                },
              ),
              const Gap(AppSpacing.md),

              // Phone Field
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText:
                      l10n?.submitFormPhone ?? 'Contact Phone (optional)',
                  border: OutlineInputBorder(borderRadius: AppRadius.borderMd),
                ),
              ),
              const Gap(AppSpacing.md),

              // Notes Field
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText:
                      l10n?.submitFormNotes ??
                      'Notes & Halal Evidence (optional)',
                  border: OutlineInputBorder(borderRadius: AppRadius.borderMd),
                ),
              ),

              const Gap(AppSpacing.xl),

              // Submit Button
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
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send_rounded),
                  label: Text(
                    l10n?.submitButton ?? 'Submit Contribution',
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
    );
  }
}
