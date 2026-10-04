import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceSubmission {
  final String id;
  final String submissionType; // 'new_place', 'edit_place', 'report_issue'
  final String name;
  final String category;
  final String address;
  final String province;
  final String? phone;
  final String? notes;
  final String status; // 'pending', 'in_review', 'approved', 'rejected'
  final DateTime createdAt;

  PlaceSubmission({
    required this.id,
    required this.submissionType,
    required this.name,
    required this.category,
    required this.address,
    required this.province,
    this.phone,
    this.notes,
    this.status = 'pending',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class SubmissionsNotifier extends StateNotifier<List<PlaceSubmission>> {
  SubmissionsNotifier() : super([]);

  void addSubmission(PlaceSubmission submission) {
    state = [submission, ...state];
  }
}

final submissionsProvider =
    StateNotifierProvider<SubmissionsNotifier, List<PlaceSubmission>>((ref) {
      return SubmissionsNotifier();
    });
