import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/models/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final todoListProvider =
    AsyncNotifierProvider.autoDispose<TodoNotifier, Set<Todo>>(
      TodoNotifier.new,
    );

final completedTodosProvider = Provider.autoDispose<Set<Todo>>((ref) {
  final todos = ref.watch(todoListProvider) as Set;
  return todos.cast<Todo>().where((todo) => todo.isCompleted).toSet();
});
final todosProvider =
    AsyncNotifierProvider.autoDispose<TodosNotifier, List<Todo>>(
      TodosNotifier.new,
    );

class TodoNotifier extends AutoDisposeAsyncNotifier<Set<Todo>> {
  @override
  Future<Set<Todo>> build() async {
    return {
      Todo(id: "1", description: 'Learn Flutter', isCompleted: true),
      Todo(id: "2", description: 'Learn Riverpod'),
    };
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.http('your_api.com', '/todo'),
      body: jsonEncode(todo.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    // Decoding API response and converting to Set<Todo>
    Set<Todo> newTodos = (jsonDecode(response.body) as Set)
        .cast<Map<String, dynamic>>()
        .map(Todo.fromJson)
        .toSet();

    // Updating the local cache to match the new state.
    state = AsyncData(newTodos);

    // useful when GET requies is more complex, such as filtering and sorting
    ref.invalidateSelf();

    await future;
  }

  Future<Todo> fetchTodos() async {
    final response = await http.get(Uri.http('your_api.com', '/todos'));
    final json = jsonDecode(response.body);
    return Todo.fromJson(json);
  }
}

class TodosNotifier extends AutoDisposeAsyncNotifier<List<Todo>> {
  static const baseUrl = 'http://localhost/';
  @override
  Future<List<Todo>> build() async {
    ref.cacheFor(const Duration(minutes: 5));
    return _fetchTodo();
  }

  Future<List<Todo>> _fetchTodo() async {
    final response = await http.get(Uri.parse('${baseUrl}api/todos'));
    final todo = jsonDecode(response.body) as List<Map<String, dynamic>>;
    return todo.map((json) => Todo.fromJson(json)).toList();
  }

  Future<void> addTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.post(
        Uri.parse('${baseUrl}api/todos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo.toJson()),
      );
      return _fetchTodo();
    });
  }

  Future<void> removeTodo(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.delete(Uri.parse('${baseUrl}api/todos/$todoId'));
      return _fetchTodo();
    });
  }

  Future<void> toggle(String todoId) async {
    final currentTodos = state.value ?? [];
    final todo = currentTodos.firstWhere(
      (t) => t.id == todoId,
      orElse: () => throw Exception("Todo not found"),
    );

    final updatedTodos = todo.copyWith(isCompleted: !todo.isCompleted);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.patch(
        Uri.parse('${baseUrl}api/todos/$todoId'),
        body: {"isCompleted": updatedTodos.isCompleted},
      );
      return _fetchTodo();
    });
  }
}

extension CacheForExtension on Ref{
  void cacheFor(Duration duration){
    final link = keepAlive();
    final timer = Timer(duration, () => link.close());
    onDispose(timer.cancel);
  }
}
