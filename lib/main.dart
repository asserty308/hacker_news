import 'package:flutter/material.dart';
import 'package:hacker_news/ui/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await _setupApp();

  runApp(const MyApp());
}

Future<void> _setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await _initStorages();
}

Future<void> _initStorages() async {
  await Hive.initFlutter();
  
  await Future.wait([
    Hive.openBox('favorites'),
  ]);
}
