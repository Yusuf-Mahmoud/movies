import 'package:flutter/material.dart';
import 'package:movie_app/MoviesPorvider.dart';
import 'package:movie_app/MoviesSplash/view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MoviesProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        home: MoviesSplash(),
      ),
    );
  }
}
