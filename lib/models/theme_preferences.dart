import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const _themeKey = 'theme_mode';

  static Future<void> saveThemeMode(ThemeMode mode) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  static Future<ThemeMode> getThemeMode() async{
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey) ?? 'system';
    return ThemeMode.values.firstWhere((e) => e.name == themeName);
  }
}