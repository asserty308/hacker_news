import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/providers/cubit_providers.dart';
import 'package:hacker_news/ui/screens/app_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// TODO: Use setup service
// TODO: Use go_router instead of bloc
// TODO: Use Hive.initFlutter() from hive_flutter
// TODO: System theme

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Init hive db and open all boxes neesed in the app
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  await Hive.openBox('favorites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker Today',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const AppBlocProvider(
        child: AppScreen(),
      ),
    );
  }
}
