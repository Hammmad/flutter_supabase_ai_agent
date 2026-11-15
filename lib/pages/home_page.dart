import 'package:flutter/material.dart';

import '../main.dart';

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
  late final Stream<List<Map<String, dynamic>>> _todos = supabase
      .from('todos')
      .stream(primaryKey: ['id'])
      .order('created_at');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addTodo() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    try {
      await supabase.from('todos').insert({'title': title});
      _controller.clear();
    } catch (e) {
      _showError(e);
    }
  }

  Future<void> _toggle(Map<String, dynamic> todo) async {
    try {
      await supabase
          .from('todos')
          .update({'is_done': !(todo['is_done'] as bool)})
          .eq('id', todo['id']);
    } catch (e) {
      _showError(e);
    }
  }

  Future<void> _delete(Map<String, dynamic> todo) async {
    try {
      await supabase.from('todos').delete().eq('id', todo['id']);
    } catch (e) {
      _showError(e);
    }
  }

  void _showError(Object e) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $e')));
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.email ?? 'Todos'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () => supabase.auth.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'New todo'),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTodo),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _todos,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final todos = snapshot.data!;
                if (todos.isEmpty) {
                  return const Center(child: Text('No todos yet'));
                }
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, i) {
                    final todo = todos[i];
                    return CheckboxListTile(
                      value: todo['is_done'] as bool,
                      title: Text(todo['title'] as String),
                      onChanged: (_) => _toggle(todo),
                      secondary: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _delete(todo),
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
