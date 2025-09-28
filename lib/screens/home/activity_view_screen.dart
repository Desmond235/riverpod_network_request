import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityViewScreen extends ConsumerWidget {
  const ActivityViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home screen'),),
      body: const Center(
        child: Text('Click the button to open the detail page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/detail-page'),
        child: Icon(Icons.add),
      ),
    );
  }
}