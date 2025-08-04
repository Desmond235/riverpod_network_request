import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/models/activity.dart';
import 'package:riverpod_network_request/provider/activity_provider.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activityProvider(const['recreational', 'cooking', 'education']));
    return Scaffold(
      body: Center(
        child: activities.when(
          data: (value) => Column(
            children: [
              for(final activity in value)
              Text(activity.activity)
            ],
          ),
           error: (error, _) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator())
      ),
    );
  }
}
