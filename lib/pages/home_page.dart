import 'package:flutter/material.dart';

import '../custom_views/custom_views.dart';
import '../main.dart';
import 'design_system_page.dart';

/// Example of reading and writing a Supabase table in realtime.
///
/// Expects a `todos` table — see supabase/schema.sql.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  // Realtime stream of the current user's todos (filtered by RLS).
  late Stream<List<Map<String, dynamic>>> _todos = _subscribe();

  Stream<List<Map<String, dynamic>>> _subscribe() =>
      supabase.from('todos').stream(primaryKey: ['id']).order('created_at');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } catch (_) {
      if (mounted) {
        AppSnackbar.error(context, "Couldn't save that change. Try again.");
      }
    }
  }

  Future<void> _addTodo() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    _controller.clear();
    await _run(() => supabase.from('todos').insert({'title': title}));
  }

  Future<void> _toggle(Map<String, dynamic> todo) => _run(
    () => supabase
        .from('todos')
        .update({'is_done': !(todo['is_done'] as bool)})
        .eq('id', todo['id']),
  );

  Future<void> _delete(Map<String, dynamic> todo) =>
      _run(() => supabase.from('todos').delete().eq('id', todo['id']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Your todos',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _controller,
                    hint: 'Add a todo',
                    prefixIcon: Icons.add_task,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                AppSpacing.gapXs,
                AppIconButton(
                  icon: Icons.add,
                  tooltip: 'Add todo',
                  filled: true,
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _todos,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return AppEmptyState.error(
                    message: "Couldn't load your todos.",
                    onAction: () => setState(() => _todos = _subscribe()),
                  );
                }
                if (!snapshot.hasData) return const AppLoader();
                final todos = snapshot.data!;
                if (todos.isEmpty) {
                  return const AppEmptyState(
                    icon: Icons.checklist_rounded,
                    title: 'Start your first todo',
                    message: 'Type above and press enter to add one.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.lg,
                  ),
                  itemCount: todos.length,
                  separatorBuilder: (_, _) => AppSpacing.gapXs,
                  itemBuilder: (context, i) {
                    final todo = todos[i];
                    return AppCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: AppCheckbox(
                        value: todo['is_done'] as bool,
                        label: todo['title'] as String,
                        strikeThroughWhenChecked: true,
                        onChanged: (_) => _toggle(todo),
                        trailing: AppIconButton(
                          icon: Icons.delete_outline,
                          tooltip: 'Delete',
                          onPressed: () => _delete(todo),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
