import 'package:flutter/material.dart';
import 'screens/news_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI-Driven News Aggregator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
      debugShowCheckedModeBanner: false, // This line removes the debug banner
    );
  }
}
