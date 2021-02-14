import 'package:blogg/search_posts.dart';
import 'package:flutter/material.dart';
import 'search_posts.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogg',
      theme: appThemeData,
      // darkTheme: appThemeDataDark,
      home: SearchPosts(),
    );
  }
}
