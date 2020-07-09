import 'package:flutter/material.dart';
import 'package:hacker_news/features/newspaper/ui/screens/top_stories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker Today',
      theme: ThemeData.dark(),
      home: TopStoriesScreen(),
    );
  }
}
