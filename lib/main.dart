import 'package:flutter/material.dart';
import 'package:hacker_news/data/services/app_session.dart';
import 'package:hacker_news/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupSession();

  runApp(const MyApp());
}


