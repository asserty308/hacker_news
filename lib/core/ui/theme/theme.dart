import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final light = _baseTheme(Brightness.light);

  static final dark = _baseTheme(Brightness.dark);

  static ThemeData _baseTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: brightness,
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      useMaterial3: true,
    );
  }
}
