

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/models/bar_bones_model.dart';
import 'package:http/http.dart' as http;

final activityProvider = FutureProvider.autoDispose<Activity>((ref) async{
   final client = await ref.getDebouncedHttpClient();
   final response = await client.get(
    Uri.https('bored-api.appbrewery.com', '/random'),
   );
   final json = jsonDecode(response.body) as Map;
   return Activity.fromJson(Map.from(json));
});

extension DebouncedAndCancelledExtension on Ref{

  Future<http.Client>getDebouncedHttpClient([Duration? duration]) async{
    bool didDispose = false;
    onDispose(() => didDispose = true);
    await Future.delayed(duration ?? const Duration(milliseconds: 500));
    if(didDispose){
      throw Exception('Cancelled');
    }

    final client = http.Client();
    onDispose(client.close);
    return client;
  }
}