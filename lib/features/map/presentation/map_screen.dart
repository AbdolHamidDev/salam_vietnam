import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/map_launcher.dart';
import '../../../core/widgets/halal_status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/models/place.dart';
import '../../../shared/repositories/mock_places.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  Place? _selectedPlace;
  PlaceCategory _selectedCategory = PlaceCategory.all;

  @override
  void initState() {
    super.initState();
    _selectedPlace = MockPlacesRepository.samplePlaces.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final filteredPlaces = MockPlacesRepository.samplePlaces.where((p) {
      if (_selectedCategory == PlaceCategory.all) return true;
      return p.category == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.navMap ?? 'Map')),
      body: SafeArea(
        child: Stack(
          children: [
            // Map Visual Simulation Canvas with Grid & Interactive Markers
            Container(
              color: const Color(0xFFE5E9EC),
              child: Stack(
                children: [
                  // Map Background Pattern Lines
                  Center(
                    child: Opacity(
                      opacity: 0.15,
                      child: Icon(
                        Icons.map,
                        size: MediaQuery.of(context).size.width * 0.8,
                        color: AppColors.salamGreen,
                      ),
                    ),
                  ),

                  // Interactive Markers Placement on Canvas
                  ...filteredPlaces.asMap().entries.map((entry) {
                    final index = entry.key;
                    final place = entry.value;
                    final isSelected = _selectedPlace?.id == place.id;

                    // Calculate simulated map coordinates
                    final topPos = 120.0 + (index * 70.0) % 300.0;
                    final leftPos =
                        40.0 +
                        (index * 110.0) %
                            (MediaQuery.of(context).size.width - 100);

                    return Positioned(
                      top: topPos,
                      left: leftPos,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPlace = place;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.salamGreen
                                : AppColors.surfaceLight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.softGold
                                  : AppColors.salamGreen,
                              width: isSelected ? 3 : 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            place.category == PlaceCategory.mosque
                                ? Icons.account_balance
                                : place.category == PlaceCategory.chamCulture
                                ? Icons.museum
                                : Icons.restaurant,
                            color: isSelected
                                ? Colors.white
                                : AppColors.salamGreen,
                            size: isSelected ? 24 : 18,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Top Category Filter Chips Bar
            Positioned(
              top: AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: Text(l10n?.categoryAll ?? 'All'),
                      selected: _selectedCategory == PlaceCategory.all,
                      selectedColor: AppColors.salamGreen,
                      labelStyle: TextStyle(
                        color: _selectedCategory == PlaceCategory.all
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = PlaceCategory.all;
                        });
                      },
                    ),
                    const Gap(AppSpacing.xs),
                    FilterChip(
                      label: Text(l10n?.categoryHalalFood ?? 'Halal Food'),
                      selected: _selectedCategory == PlaceCategory.halalFood,
                      selectedColor: AppColors.salamGreen,
                      labelStyle: TextStyle(
                        color: _selectedCategory == PlaceCategory.halalFood
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = PlaceCategory.halalFood;
                        });
                      },
                    ),
                    const Gap(AppSpacing.xs),
                    FilterChip(
                      label: Text(l10n?.categoryMosque ?? 'Mosques'),
                      selected: _selectedCategory == PlaceCategory.mosque,
                      selectedColor: AppColors.salamGreen,
                      labelStyle: TextStyle(
                        color: _selectedCategory == PlaceCategory.mosque
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = PlaceCategory.mosque;
                        });
                      },
                    ),
                    const Gap(AppSpacing.xs),
                    FilterChip(
                      label: Text(l10n?.categoryChamCulture ?? 'Cham Culture'),
                      selected: _selectedCategory == PlaceCategory.chamCulture,
                      selectedColor: AppColors.salamGreen,
                      labelStyle: TextStyle(
                        color: _selectedCategory == PlaceCategory.chamCulture
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = PlaceCategory.chamCulture;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Selected Place Preview Floating Card
            if (_selectedPlace != null)
              Positioned(
                bottom: AppSpacing.md,
                left: AppSpacing.md,
                right: AppSpacing.md,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.borderLg,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: AppRadius.borderMd,
                              child: Image.network(
                                _selectedPlace!.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 70,
                                      height: 70,
                                      color: AppColors.surfaceSubtle,
                                      child: const Icon(
                                        Icons.image_not_supported_outlined,
                                      ),
                                    ),
                              ),
                            ),
                            const Gap(AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HalalStatusBadge(
                                    status: _selectedPlace!.halalStatus,
                                    isCompact: true,
                                  ),
                                  const Gap(4),
                                  Text(
                                    _selectedPlace!.name,
                                    style: AppTypography.titleMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Gap(2),
                                  Text(
                                    '${_selectedPlace!.address}, ${_selectedPlace!.province}',
                                    style: AppTypography.caption,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(AppSpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.salamGreen,
                                  side: const BorderSide(
                                    color: AppColors.salamGreen,
                                  ),
                                ),
                                onPressed: () {
                                  context.push('/place/${_selectedPlace!.id}');
                                },
                                child: Text(l10n?.details ?? 'Details'),
                              ),
                            ),
                            const Gap(AppSpacing.sm),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.salamGreen,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  MapLauncher.launchDirections(
                                    latitude:
                                        _selectedPlace!.latitude ?? 10.7769,
                                    longitude:
                                        _selectedPlace!.longitude ?? 106.7051,
                                    placeName: _selectedPlace!.name,
                                    context: context,
                                  );
                                },
                                icon: const Icon(Icons.directions, size: 16),
                                label: Text(l10n?.directions ?? 'Directions'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
