/// Supabase credentials, injected at build time via:
///   flutter run --dart-define-from-file=env.json
class SupabaseConfig {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static bool get isConfigured =>
      url.isNotEmpty &&
      publishableKey.isNotEmpty &&
      !url.contains('YOUR_PROJECT_REF');
}
