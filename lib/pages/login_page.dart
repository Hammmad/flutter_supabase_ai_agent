import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../custom_views/custom_views.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _signingIn = false;
  bool _signingUp = false;

  bool get _busy => _signingIn || _signingUp;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit({required bool signUp}) async {
    if (_busy || !_formKey.currentState!.validate()) return;
    setState(() => signUp ? _signingUp = true : _signingIn = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    try {
      if (signUp) {
        final res = await supabase.auth.signUp(
          email: email,
          password: password,
        );
        if (res.session == null && mounted) {
          AppSnackbar.success(
            context,
            'Check your inbox to confirm your email.',
          );
        }
      } else {
        await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      }
    } on AuthException catch (e) {
      if (mounted) AppSnackbar.error(context, e.message);
    } catch (_) {
      if (mounted) {
        AppSnackbar.error(context, "Couldn't reach the server. Try again.");
      }
    } finally {
      if (mounted) setState(() => _signingIn = _signingUp = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Welcome back', style: AppTextStyles.title),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'Sign in to your workspace.',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      AppSpacing.gapXl,
                      AppTextField.email(
                        controller: _emailController,
                        validator: (v) => (v == null || !v.contains('@'))
                            ? 'Enter a valid email'
                            : null,
                      ),
                      AppSpacing.gapMd,
                      AppTextField.password(
                        controller: _passwordController,
                        onSubmitted: (_) => _submit(signUp: false),
                        validator: (v) => (v == null || v.length < 6)
                            ? 'Use at least 6 characters'
                            : null,
                      ),
                      AppSpacing.gapLg,
                      AppButton(
                        label: 'Sign in',
                        isLoading: _signingIn,
                        onPressed: () => _submit(signUp: false),
                      ),
                      AppSpacing.gapSm,
                      AppButton.secondary(
                        label: 'Create account',
                        isLoading: _signingUp,
                        onPressed: () => _submit(signUp: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
