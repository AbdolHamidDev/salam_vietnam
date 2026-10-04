import 'package:flutter_test/flutter_test.dart';
import 'package:salam_vietnam/shared/repositories/mock_places.dart';

void main() {
  group('MockPlacesRepository Tests', () {
    test('samplePlaces contains valid pilot records', () {
      final places = MockPlacesRepository.samplePlaces;

      expect(places, isNotEmpty);
      expect(places.length, greaterThanOrEqualTo(5));

      for (final place in places) {
        expect(place.id, isNotEmpty);
        expect(place.name, isNotEmpty);
        expect(place.address, isNotEmpty);
        expect(place.province, isNotEmpty);
        expect(place.isSampleData, isTrue);
      }
    });
  });
}
