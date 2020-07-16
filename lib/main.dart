import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hacker_news/data/repositories/favorites_repository.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/bloc/app/app_cubit.dart';
import 'package:hacker_news/bloc/favorites_screen/favorites_screen_cubit.dart';
import 'package:hacker_news/bloc/top_stories_screen/top_stories_cubit.dart';
import 'package:hacker_news/ui/screens/app_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Init hive db and open all boxes neesed in the app
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  await Hive.openBox('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker Today',
      theme: ThemeData.dark(),
      home: MultiCubitProvider(
        providers: [
          CubitProvider(
            create: (context) => AppCubit(),
          ),
          CubitProvider(
            create: (context) => FavoritesCubit(globalFavoritesRepository),
          ),
          CubitProvider(
            create: (context) => TopStoriesCubit(globalHackernewsRepo),
          ),
        ],
        child: AppScreen(),
      ),
    );
  }
}
