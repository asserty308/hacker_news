import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/providers/cubit_providers.dart';
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
      debugShowCheckedModeBanner: false,
      home: AppBlocProvider(
        child: AppScreen(),
      ),
    );
  }
}
