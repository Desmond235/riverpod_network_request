import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_network_request/models/activity.dart';

final activityProvider = AsyncNotifierProvider.autoDispose
    .family<ActivityNotifier, List<Activity>, List<String>>(ActivityNotifier.new);

class ActivityNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<Activity>, List<String>> {
  @override
  Future<List<Activity>> build(List<String> activityType) async {
   return _fetchActivity(activityType);
  }

  Future<List<Activity>> _fetchActivity(List<String> activityType) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _activity = state.value ?? [];
    for(final activity in activityType){
      final response = await http.get(
      Uri.https('bored-api.appbrewery.com', '/$activity'),
    );
    final json = jsonDecode(response.body);
    _activity.add(Activity.fromJSon(json));
    }
    return _activity;
  }
}
