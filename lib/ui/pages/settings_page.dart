import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/config/app_config.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/data/services/app_session.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/router/router.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      restorationId: 'settings_list',
      slivers: [
        SliverAppBar(
          title: Text(context.l10n.settings),
          floating: true,
        ),
        _body(context),
      ],
    ),
  );

  Widget _body(BuildContext context) => SliverList.list(
    children: [
      _favoritesTile(context),
      _licensesTile(context),
      _showGitHubRepoTile(context),
      //_clearHistoryCacheTile(context),
      _versionTileBuilder(context),
    ],
  );

  Widget _favoritesTile(BuildContext context) => ListTile(
    title: const Text('My Favorites'),
    onTap: () => appRouter.push('/favorites'),
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
    onTap: () => launchUrl(Uri.parse(kGitHubRepoUrl))
  );

  // Widget _clearHistoryCacheTile(BuildContext context) => ListTile(
  //   title: const Text('Clear History Cache'),
  //   subtitle: const Text('This will make already seen stories appear again'),
  //   onTap: () => RepositoryProvider.of<StoryHistoryRepo>(context).clear(),
  // );

  Widget _versionTileBuilder(BuildContext context) => ListTile(
    subtitle: Text(context.l10n.appVersion(appPackageInfo?.version ?? 'n.A.')),
  );
}