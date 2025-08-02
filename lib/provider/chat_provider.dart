import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

final chatProvider = StreamProvider<List<String>>((ref) async*{
  final socket = await Socket.connect('localhost', 4040);
  ref.onDispose(socket.close);

  var allMessages = const <String>[];
  await for (final message in socket.map(utf8.decode)){
    allMessages = [...allMessages, message];
    yield allMessages;
  }
});