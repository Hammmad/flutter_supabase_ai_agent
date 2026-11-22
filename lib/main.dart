import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'custom_views/custom_views.dart';
import 'pages/design_system_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.publishableKey,
    );
  }

  runApp(const MyApp());
}

/// Shortcut to the Supabase client. Only valid after [Supabase.initialize].
SupabaseClient get supabase => Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Example',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: SupabaseConfig.isConfigured
          ? const AuthGate()
          : const MissingConfigPage(),
    );
  }
}

/// Shows the login page or the home page depending on the auth session,
/// and reacts to sign-in / sign-out events.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? supabase.auth.currentSession;
        return session == null ? const LoginPage() : const HomePage();
      },
    );
  }
}

class MissingConfigPage extends StatelessWidget {
  const MissingConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppEmptyState(
        icon: Icons.key_outlined,
        title: 'Supabase is not configured',
        message:
            'Fill in env.json with your project URL and publishable key, then run:\n'
            'flutter run --dart-define-from-file=env.json',
        actionLabel: 'View components',
        onAction: () => DesignSystemPage.open(context),
      ),
    );
  }
}
