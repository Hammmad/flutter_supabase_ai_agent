import 'package:flutter/material.dart';

import '../custom_views/custom_views.dart';
import '../main.dart';
import 'design_system_page.dart';

/// Signed-in home. Placeholder until the workspace screens
/// (Documents, Chat, Tasks) are built in later milestones.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'AI Workspace',
        subtitle: supabase.auth.currentUser?.email,
        actions: [
          AppIconButton(
            icon: Icons.palette_outlined,
            tooltip: 'Components',
            onPressed: () => DesignSystemPage.open(context),
          ),
          AppIconButton(
            icon: Icons.logout,
            tooltip: 'Sign out',
            onPressed: () => supabase.auth.signOut(),
          ),
        ],
      ),
      body: const AppEmptyState(
        icon: Icons.workspaces_outline,
        title: "You're signed in",
        message: 'Documents, chat and tasks are coming next.',
      ),
    );
  }
}
