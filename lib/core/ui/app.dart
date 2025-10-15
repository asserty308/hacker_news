import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/config/theme.dart';
import 'package:hacker_news/core/di/providers.dart';
import 'package:hacker_news/l10n/generated/app_localizations.dart';
import 'package:hacker_news/l10n/l10n.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends AppConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    restorationScopeId: 'app',
    onGenerateTitle: (context) => context.l10n.appTitle,
    theme: lightTheme,
    darkTheme: darkTheme,
    debugShowCheckedModeBanner: false,
    routerConfig: ref.read(appRouterProvider),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
