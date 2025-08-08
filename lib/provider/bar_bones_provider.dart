import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/models/bar_bones_model.dart';
import 'package:http/http.dart' as http;

final activityProvider = FutureProvider.autoDispose<Activity>((ref) async{
  final response = await http.get(Uri.https('bored-api.appbrewery.com','/random'));
  final json = jsonDecode(response.body);
  return Activity.fromJson(json);
});