import 'package:flutter/material.dart';
import 'package:hacker_news/config/app_config.dart';
import 'package:hacker_news/data/services/app_session.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text(context.l10n.settings),
          floating: true,
          actions: const [
            HomeAction(),
            FavoritesAction(),
          ],
        ),
        _body(context),
      ],
    ),
  );

  Widget _body(BuildContext context) => SliverList.list(
    children: [
      _licensesTile(context),
      _showGitHubRepoTile(context),
      _versionTileBuilder(context),
    ],
  );

  Widget _licensesTile(BuildContext context) => ListTile(
    title: Text(context.l10n.osl),
    onTap: () => showLicensePage(
      context: context,
      applicationVersion: appPackageInfo?.version,
    ),
  );

  Widget _showGitHubRepoTile(BuildContext context) => ListTile(
    title: Text(context.l10n.sourceCode),
    onTap: () => launchUrl(Uri.parse(gitHubRepoUrl))
  );

  Widget _versionTileBuilder(BuildContext context) => ListTile(
    subtitle: Text(context.l10n.appVersion(appPackageInfo?.version ?? 'n.A.')),
  );
}