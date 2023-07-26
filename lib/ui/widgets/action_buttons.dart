import 'package:flutter/material.dart';
import 'package:hacker_news/router/router.dart';

class HomeAction extends StatelessWidget {
  const HomeAction({super.key});

  @override
  Widget build(BuildContext context) => IconButton(icon: const Icon(Icons.list), onPressed: () => appRouter.go('/'));
}

class FavoritesAction extends StatelessWidget {
  const FavoritesAction({super.key});

  @override
  Widget build(BuildContext context) => IconButton(icon: const Icon(Icons.favorite), onPressed: () => appRouter.go('/favorites'));
}

class SettingsAction extends StatelessWidget {
  const SettingsAction({super.key});

  @override
  Widget build(BuildContext context) => IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => appRouter.go('/settings'));
}
