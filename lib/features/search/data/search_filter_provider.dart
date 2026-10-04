import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/place.dart';
import '../../../shared/repositories/mock_places.dart';
import '../../explore/presentation/explore_screen.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedProvinceProvider = StateProvider<String?>((ref) => null);
final selectedHalalStatusFilterProvider = StateProvider<HalalStatus?>(
  (ref) => null,
);

final filteredPlacesProvider = Provider<List<Place>>((ref) {
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final province = ref.watch(selectedProvinceProvider);
  final halalStatus = ref.watch(selectedHalalStatusFilterProvider);

  return MockPlacesRepository.samplePlaces.where((place) {
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
