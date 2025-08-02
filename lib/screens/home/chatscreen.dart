import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/provider/chat_provider.dart';

class Chatscreen extends ConsumerWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveChats = ref.watch(chatProvider);
    return liveChats.when(
      data: (value) => ListView.builder(
        reverse: true,
        itemCount: value.length,
        itemBuilder: (c,i){
          final message = value[i];
          return Text(message);
      }),
      error: (error, stack) => Text('Error: $error'),
      loading: () => const CircularProgressIndicator()
    );
  }
}