import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker Today',
      theme: ThemeData.dark(),
      home: Container(color: Colors.red,),
    );
  }
}
