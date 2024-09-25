import 'package:flutter/material.dart';

ThemeData appTheme(bool isDark) => ThemeData(
  useMaterial3: true,
  colorScheme: isDark ? _darkColorScheme : _lightColorScheme,
);

const _lightColorScheme = ColorScheme.light();

const _darkColorScheme = ColorScheme.dark();
