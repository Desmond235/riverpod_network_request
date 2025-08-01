import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_network_request/models/activity.dart';

final activityProvider = FutureProvider.autoDispose((ref) async {
  final response = await  http.get(Uri.https('bored-api.appbrewery.com', '/random'));
  final json = jsonDecode(response.body);
  return Activity.fromJSon(json);
});