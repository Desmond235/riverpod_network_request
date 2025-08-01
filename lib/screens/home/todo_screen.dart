import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/models/todo.dart';
import 'package:riverpod_network_request/provider/todolist_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref
                .read(todoListProvider.notifier)
                .addTodo(Todo(id: "3", description: 'Go to the conference'));
          },
          child: const Text('Add Todo'),
        ),
      ),
    );
  }
}
