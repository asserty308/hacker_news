import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/common/setup.dart';
import 'package:hacker_news/core/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupApp();

  runApp(const ProviderScope(child: MyApp()));
}
