enum PlaceCategory { halalFood, mosque, accommodation, chamCulture, all }

enum HalalStatus { verified, selfDeclared, unverified, expired, disputed }

enum VerificationStatus {
  fieldVerified,
  sourceConfirmed,
  communityConfirmed,
  unverified,
}

class Place {
  final String id;
  final String name;
  final PlaceCategory category;
  final HalalStatus halalStatus;
  final VerificationStatus verificationStatus;
  final String address;
  final String province;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double? latitude;
  final double? longitude;
  final bool isSampleData;
  final DateTime? lastVerifiedAt;
  final String? evidenceSummary;
  final String description;
  final String? phone;

  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.halalStatus,
    required this.verificationStatus,
    required this.address,
    required this.province,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    this.latitude,
    this.longitude,
    this.isSampleData = true,
    this.lastVerifiedAt,
    this.evidenceSummary,
    this.phone,
  });
}
