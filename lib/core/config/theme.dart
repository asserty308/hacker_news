import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _lightColorScheme,
);

final darkTheme = ThemeData(useMaterial3: true, colorScheme: _darkColorScheme);

final _lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueGrey,
  brightness: Brightness.light,
);

final _darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueGrey,
  brightness: Brightness.dark,
);
