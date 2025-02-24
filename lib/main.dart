import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/domain/setup.dart';
import 'package:hacker_news/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupApp();

  runApp(const ProviderScope(child: MyApp()));
}
