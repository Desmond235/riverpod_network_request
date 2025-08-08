import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/provider/bar_bones_provider.dart';

class Activityscreen extends ConsumerWidget {
  const Activityscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activity = ref.watch(activityProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Pull to referesh')),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(activityProvider.future),
        child: Center(
          child: ListView(
            children: [
              activity.when(
                data: (value) => Text(value.activity),
                error: (error, _) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
              ),
            ],
          )
        ),
      ),
    );
  }
}