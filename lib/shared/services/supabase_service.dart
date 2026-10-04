import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/supabase_config.dart';

class SupabaseService {
  static Future<void> initialize() async {
    if (SupabaseConfig.isConfigured) {
      try {
        await Supabase.initialize(
          url: SupabaseConfig.url,
          // ignore: deprecated_member_use
          anonKey: SupabaseConfig.anonKey,
        );
        debugPrint('Supabase initialized successfully.');
      } catch (e) {
        debugPrint('Supabase init warning: $e');
      }
    } else {
      debugPrint(
        'Supabase is not yet configured. Operating in Offline/Mock Data mode.',
      );
    }
  }

  static SupabaseClient? get client {
    if (SupabaseConfig.isConfigured) {
      try {
        return Supabase.instance.client;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
