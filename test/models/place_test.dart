import 'package:flutter_test/flutter_test.dart';
import 'package:salam_vietnam/shared/models/place.dart';

void main() {
  group('Place Model Tests', () {
    test('Place model instantiation with sample data tag', () {
      final place = Place(
        id: 'p_test',
        name: 'Test Place',
        category: PlaceCategory.halalFood,
        halalStatus: HalalStatus.verified,
        verificationStatus: VerificationStatus.fieldVerified,
        address: '123 Test Street',
        province: 'TP. Hồ Chí Minh',
        imageUrl: 'https://example.com/image.jpg',
        rating: 4.8,
        reviewCount: 50,
        description: 'Test description',
        isSampleData: true,
      );

      expect(place.id, equals('p_test'));
      expect(place.name, equals('Test Place'));
      expect(place.category, equals(PlaceCategory.halalFood));
      expect(place.halalStatus, equals(HalalStatus.verified));
      expect(
        place.verificationStatus,
        equals(VerificationStatus.fieldVerified),
      );
      expect(place.isSampleData, isTrue);
    });
  });
}
