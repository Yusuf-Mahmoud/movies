import 'package:flutter/material.dart';

class MoviesCategories extends StatelessWidget {
  const MoviesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: const Text(
          'Movies Categories',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
