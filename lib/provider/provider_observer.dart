import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyObserver extends ProviderObserver {
  void writeFile(String message) async {
    await logFile.writeAsString(message);
  }

  final logFile = File('log_file.txt');
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) async {
    final message = 'Povider $provider was initialized with $value';
    writeFile(message);
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    final message = 'Provider $provider was disposed';
    writeFile(message);
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final message =
        'Provider $provider was updated from $previousValue to $newValue';
    writeFile(message);
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final message = 'Provider $provider threw $error at $stackTrace';
    writeFile(message);
    super.providerDidFail(provider, error, stackTrace, container);
  }
}
