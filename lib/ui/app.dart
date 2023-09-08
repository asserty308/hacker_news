import 'package:flutter/material.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hacker_news/styles/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    restorationScopeId: 'app',
    onGenerateTitle: (context) => context.l10n.appTitle,
    theme: lightTheme,
    darkTheme: darkTheme,
    debugShowCheckedModeBanner: false,
    routerConfig: appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
