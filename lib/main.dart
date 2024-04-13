import 'package:flutter/material.dart';
import 'package:movies/HomeScreen.dart';
import 'package:movies/Theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.ligthTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: HomeScreen(),
  
  );
  }
}