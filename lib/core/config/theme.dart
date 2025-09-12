import 'package:flutter/material.dart';

ThemeData appTheme(bool isDark) => ThemeData(
  useMaterial3: true,
  colorScheme: isDark ? _darkColorScheme : _lightColorScheme,
);

final _lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.light,
);

final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
);
