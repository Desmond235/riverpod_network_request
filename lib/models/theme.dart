import 'package:flutter/material.dart';

class ThemeSettings {
  final ThemeMode mode;
  final Color color;

  ThemeSettings({required this.mode, required this.color});

  ThemeSettings copyWith({
    final ThemeMode? mode,
    final Color? color,
  }){
    return ThemeSettings(
      mode: mode ?? this.mode,
      color: color ?? this.color
    );
  }
}

extension ThemeExtension on ThemeMode{
  ThemeMode get toggle{
    switch(this){
      case ThemeMode.light:
      return ThemeMode.dark;
      case ThemeMode.dark:
      return ThemeMode.light;
      default:
      return ThemeMode.light;

    }
  }
}
