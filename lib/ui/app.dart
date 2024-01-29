import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/bloc/top_stories/top_stories_cubit.dart';
import 'package:hacker_news/l10n/l10n.dart';
import 'package:hacker_news/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hacker_news/styles/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    // Initialize the AppLifecycleListener class and pass callbacks
    _listener = AppLifecycleListener(
      onResume: _onResume,
    );
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

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

  void _onResume() => BlocProvider.of<TopStoriesCubit>(context).refresh();
}
