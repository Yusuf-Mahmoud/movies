import 'package:flutter/material.dart';
import 'package:movie_app/MoviesPorvider.dart';
import 'package:movie_app/core/colors.dart';
import 'package:provider/provider.dart';

class MoviesBase extends StatelessWidget {
  const MoviesBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (BuildContext context, MoviesProvider provider, Widget? child) =>
          Scaffold(
        backgroundColor: AppColors().appBackground,
        bottomNavigationBar: buildBottomNavigationBar(provider),
        body: PageView(
          controller: provider.pageController,
          onPageChanged: (int index) {
            provider.setScreenIndex(index);
          },
          children: provider.screens,
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(MoviesProvider provider) {
    return BottomNavigationBar(
      currentIndex: provider.screenIndex,
      onTap: (int index) {
        provider.setScreenIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors().navigationBar,
      selectedItemColor: AppColors().selectedNavigationBarItem,
      unselectedItemColor: AppColors().unSelectedNavigationBarItem,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_filter),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Watchlist',
        ),
      ],
    );
  }
}