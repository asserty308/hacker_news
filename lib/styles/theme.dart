import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(),
  appBarTheme: _appBarTheme,
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 38, 56, 70), 
    brightness: Brightness.dark,
  ),
  appBarTheme: _appBarTheme,
);

AppBarTheme get _appBarTheme => const AppBarTheme(
  centerTitle: true,
);
