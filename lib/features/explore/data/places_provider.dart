import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/place.dart';
import '../../../shared/repositories/places_repository.dart';
import '../../search/data/search_filter_provider.dart';
import '../presentation/explore_screen.dart';

final allPlacesProvider = FutureProvider<List<Place>>((ref) async {
  final repository = ref.watch(placesRepositoryProvider);
  return await repository.getPlaces();
});

final filteredPlacesAsyncProvider = Provider<AsyncValue<List<Place>>>((ref) {
  final placesAsync = ref.watch(allPlacesProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final province = ref.watch(selectedProvinceProvider);
  final halalStatus = ref.watch(selectedHalalStatusFilterProvider);

  return placesAsync.whenData((places) {
    return places.where((place) {
      // 1. Filter by category
      if (category != PlaceCategory.all && place.category != category) {
        return false;
      }

      // 2. Filter by search query
      if (query.isNotEmpty) {
        final nameMatch = place.name.toLowerCase().contains(query);
        final addressMatch = place.address.toLowerCase().contains(query);
        final descMatch = place.description.toLowerCase().contains(query);
        final provinceMatch = place.province.toLowerCase().contains(query);
        if (!nameMatch && !addressMatch && !descMatch && !provinceMatch) {
          return false;
        }
      }

      // 3. Filter by province
      if (province != null &&
          province.isNotEmpty &&
          province != 'Tất cả' &&
          province != 'All') {
        if (place.province != province) {
          return false;
        }
      }

      // 4. Filter by Halal Status
      if (halalStatus != null) {
        if (place.halalStatus != halalStatus) {
          return false;
        }
      }

      return true;
    }).toList();
  });
});
