import 'package:flutter/material.dart';
import 'package:hacker_news/data/services/app_session.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/ui/widgets/action_buttons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: Text(getL10n(context).settings),
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
      _versionTileBuilder(context),
    ],
  );

  Widget _licensesTile(BuildContext context) => ListTile(
    title: Text(getL10n(context).osl),
    onTap: () => showLicensePage(
      context: context,
      applicationVersion: appPackageInfo?.version,
    ),
  );

  Widget _versionTileBuilder(BuildContext context) => ListTile(
    subtitle: Text(getL10n(context).appVersion(appPackageInfo?.version ?? 'n.A.')),
  );
}