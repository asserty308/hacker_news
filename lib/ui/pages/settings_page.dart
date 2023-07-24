import 'package:flutter/material.dart';
import 'package:hacker_news/router/router.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    body: ListView(
      children: [
        _licensesTile(context),
        _versionTileBuilder,
      ],
    ),
  );

  Widget _licensesTile(BuildContext context) => ListTile(
    title: const Text('Open Source Licenses'),
    onTap: () => showLicensePage(
      context: context,
    ),
  );

  Widget get _versionTileBuilder => FutureBuilder(
    future: PackageInfo.fromPlatform(),
    builder: (context, snapshot) {
      final data = snapshot.data;

      if (data == null) {
        return const SizedBox();
      }

      return ListTile(
        subtitle: Text('Version ${data.version}'),
      );
    },
  );
}