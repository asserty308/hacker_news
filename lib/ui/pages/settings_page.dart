import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hacker_news/domain/blocs/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/config/app_config.dart';
import 'package:hacker_news/data/repositories/story_history_repo.dart';
import 'package:hacker_news/domain/services/app_session.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/router/router.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
      _clearHistoryCacheTile(context),
      _licensesTile(context),
      _showGitHubRepoTile(context),
      _versionTileBuilder(context),
    ],
  );

  Widget _favoritesTile(BuildContext context) => ListTile(
    title: Text(context.l10n.myFavoritesTileTitle),
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

  Widget _clearHistoryCacheTile(BuildContext context) => ListTile(
    title: Text(context.l10n.clearHistoryCacheTileTitle),
    subtitle: Text(context.l10n.clearHistoryCacheTileSubtitle),
    onTap: _onClearCachePressed,
  );

  Widget _versionTileBuilder(BuildContext context) => ListTile(
    subtitle: Text(context.l10n.appVersion(appPackageInfo?.version ?? 'n.A.')),
  );

  Future<void> _onClearCachePressed() async {
    final clearCache = await showDialog<bool?>(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(context.l10n.clearHistoryCacheDialogTitle),
        content: Text(context.l10n.clearHistoryCacheDialogBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(false), 
            child: Text(context.l10n.no),
          ),
          TextButton(
            onPressed: () => context.pop(true), 
            child: Text(context.l10n.yes),
          ),
        ],
      )
    );

    if (mounted && clearCache == true) {
      await context.read<StoryHistoryRepo>().clear();

      if (!mounted) {
        return;
      }

      context.read<TopStoriesCubit>().refresh(true);
    }
  }
}