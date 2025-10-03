import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/config/constants.dart';
import 'package:hacker_news/core/di/providers.dart';
import 'package:hacker_news/core/navigation/extensions/navigation_context.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends AppConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _scrollView),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: _footer(context),
        ),
      ],
    ),
  );

  Widget get _scrollView => CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    restorationId: 'settings_list',
    slivers: [
      SliverAppBar(title: Text(context.l10n.settings), floating: true),
      _body(context),
    ],
  );

  Widget _body(BuildContext context) => SliverList.list(
    children: [
      _favoritesTile(context),
      _licensesTile(context),
      _showGitHubRepoTile(context),
    ],
  );

  Widget _favoritesTile(BuildContext context) => ListTile(
    title: Text(context.l10n.myFavoritesTileTitle),
    onTap: () => context.pushToFavorites(),
  );

  Widget _licensesTile(BuildContext context) => ListTile(
    title: Text(context.l10n.osl),
    onTap: () async {
      final appVersion = await ref.read(appInfoServiceProvider).getAppVersion();
      if (context.mounted) {
        context.pushToLicenses(appVersion);
      }
    },
  );

  Widget _showGitHubRepoTile(BuildContext context) => ListTile(
    title: Text(context.l10n.sourceCode),
    onTap: () => launchUrl(Uri.parse(kGitHubRepoUrl)),
  );

  Widget _footer(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_versionText],
      ),
    ),
  );

  Widget get _versionText => FutureBuilder<String>(
    future: ref.read(appInfoServiceProvider).getAppVersion(),
    builder: (context, snapshot) {
      final version = snapshot.data ?? 'n.A.';
      return Text(
        context.l10n.appVersion(version),
        style: context.textTheme.bodySmall,
      );
    },
  );
}
