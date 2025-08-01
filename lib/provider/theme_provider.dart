import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/models/theme.dart';
import 'package:riverpod_network_request/models/theme_preferences.dart';

final themeProvider =
    NotifierProvider.autoDispose<ThemeNotifier, ThemeSettings>(
      ThemeNotifier.new,
    );

class ThemeNotifier extends AutoDisposeNotifier<ThemeSettings> {
  @override
  ThemeSettings build() {
    _loadTheme();
    return ThemeSettings(mode: ThemeMode.system, color: Colors.blue);
  }

 void _loadTheme() async{
  final mode = await ThemePreferences.getThemeMode();
  state = state.copyWith(mode: mode);
  }

  void _saveThemeMode(ThemeMode mode){
    ThemePreferences.saveThemeMode(mode);
  }
  void toggle() {
    final newMode = state.mode.toggle;
    state = state.copyWith(mode: newMode);
    _saveThemeMode(newMode);
  }

  void setDarkTheme() {
    state = state.copyWith(mode: ThemeMode.dark);
    _saveThemeMode(ThemeMode.dark);
  }

  void setLightTheme() {
    state = state.copyWith(mode: ThemeMode.light);
    _saveThemeMode(ThemeMode.light);
  }

  void setSystemTheme() {
    state = state.copyWith(mode: ThemeMode.system);
    _saveThemeMode(ThemeMode.system);
  }

  void setPrimaryColor(Color color) {
    state = state.copyWith(color: color);
  }
}
