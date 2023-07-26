import 'package:flutter/material.dart';
import 'package:hacker_news/data/services/app_session.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Settings'),
      actions: const [
        HomeAction(),
        FavoritesAction(),
      ],
    ),
    body: _body(context),
  );

  Widget _body(BuildContext context) => ListView(
    children: [
      _licensesTile(context),
      _versionTileBuilder,
    ],
  );

  Widget _licensesTile(BuildContext context) => ListTile(
    title: const Text('Open Source Licenses'),
    onTap: () => showLicensePage(
      context: context,
      applicationVersion: appPackageInfo?.version,
    ),
  );

  Widget get _versionTileBuilder => ListTile(
    subtitle: Text('Version ${appPackageInfo?.version ?? 'n.A.'}'),
  );
}