import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/provider/todolist_provider.dart';

class TodolistView extends ConsumerWidget {
  const TodolistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    final notifier = ref.watch(todosProvider.notifier);

    return todos.when(
      data: (value) => ListView(
        children: [
          for (final todo in value)
            CheckboxListTile(
              value: todo.isCompleted,
              onChanged: (value) {
                notifier.toggle(todo.id);
              },
              title: Text(todo.description),
            ),
        ],
      ),
      error: (error, stack) => Text('Error: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
