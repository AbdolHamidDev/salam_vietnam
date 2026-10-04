import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/contributions/data/submissions_provider.dart';
import '../models/place.dart';
import '../services/supabase_service.dart';
import 'mock_places.dart';

abstract class PlacesRepository {
  Future<List<Place>> getPlaces();
  Future<bool> submitContribution(PlaceSubmission submission);
}

class DefaultPlacesRepository implements PlacesRepository {
  @override
  Future<List<Place>> getPlaces() async {
    final client = SupabaseService.client;
    if (client == null) {
      // Return sample pilot dataset when Supabase is not configured
      return MockPlacesRepository.samplePlaces;
    }

    try {
      final response = await client
          .from('places')
          .select('''
        *,
        place_translations(*),
        halal_verifications(*)
      ''')
          .eq('publication_status', 'published');

      final List<Place> places = [];
      for (final item in response as List) {
        final translations = item['place_translations'] as List? ?? [];
        final verifications = item['halal_verifications'] as List? ?? [];

        final viTranslation = translations.firstWhere(
          (t) => t['language_code'] == 'vi',
          orElse: () => translations.isNotEmpty ? translations.first : {},
        );

        final verification = verifications.isNotEmpty
            ? verifications.first
            : {};

        final categoryEnum = switch (item['place_type'] as String? ?? '') {
          'halal_food' => PlaceCategory.halalFood,
          'mosque' => PlaceCategory.mosque,
          'cham_culture' => PlaceCategory.chamCulture,
          'accommodation' => PlaceCategory.accommodation,
          _ => PlaceCategory.halalFood,
        };

        final halalStatusEnum = switch (verification['status'] as String? ??
            '') {
          'verified' => HalalStatus.verified,
          'self_declared' => HalalStatus.selfDeclared,
          'expired' => HalalStatus.expired,
          'disputed' => HalalStatus.disputed,
          _ => HalalStatus.unverified,
        };

        places.add(
          Place(
            id: item['id'] as String,
            name: viTranslation['name'] as String? ?? 'Chưa có tên',
            category: categoryEnum,
            halalStatus: halalStatusEnum,
            verificationStatus: VerificationStatus.sourceConfirmed,
            address: item['address'] as String? ?? '',
            province: item['province'] as String? ?? '',
            imageUrl: item['image_url'] as String? ?? 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600',
            rating: (item['rating'] as num?)?.toDouble() ?? 4.5,
            reviewCount: item['review_count'] as int? ?? 0,
            description: viTranslation['description'] as String? ?? '',
            phone: item['phone'] as String?,
            evidenceSummary: verification['evidence_summary'] as String?,
            isSampleData: false,
          ),
        );
      }
      return places.isNotEmpty ? places : MockPlacesRepository.samplePlaces;
    } catch (e) {
      debugPrint(
        'Error fetching places from Supabase: $e. Falling back to pilot sample data.',
      );
      return MockPlacesRepository.samplePlaces;
    }
  }

  @override
  Future<bool> submitContribution(PlaceSubmission submission) async {
    final client = SupabaseService.client;
    if (client == null) {
      return true; // Accepted locally
    }

    try {
      await client.from('place_submissions').insert({
        'submission_type': submission.submissionType,
        'payload': {
          'name': submission.name,
          'category': submission.category,
          'address': submission.address,
          'province': submission.province,
          'phone': submission.phone,
          'notes': submission.notes,
        },
        'status': 'pending',
      });
      return true;
    } catch (e) {
      debugPrint('Error submitting contribution to Supabase: $e');
      return false;
    }
  }
}

final placesRepositoryProvider = Provider<PlacesRepository>((ref) {
  return DefaultPlacesRepository();
});
