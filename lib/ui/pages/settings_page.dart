import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hacker_news/router/router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Settings'),
      actions: [
        IconButton(icon: const Icon(Icons.list), onPressed: () => appRouter.go('/')),
        IconButton(icon: const Icon(Icons.favorite), onPressed: () => appRouter.go('/favorites')),
      ],
    ),
    body: const Placeholder(),
  );
}