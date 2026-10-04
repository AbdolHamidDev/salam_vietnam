abstract class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://placeholder.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'placeholder_anon_key',
  );

  static bool get isConfigured {
    return url != 'https://placeholder.supabase.co' &&
        anonKey != 'placeholder_anon_key' &&
        url.isNotEmpty &&
        anonKey.isNotEmpty;
  }
}
