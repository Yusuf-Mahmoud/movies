import 'package:flutter/material.dart';
import 'package:movies/Hometab/home_tab.dart';
import 'package:movies/Searchtab/search_tab.dart';
import 'package:movies/browsetab/Browse_tab.dart';
import 'package:movies/watchlisttab/watchlist_tab.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget > movies = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    WatchlistTab(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: movies[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _currentIndex = index;
            setState(() {});
          },
          items: const [
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
        ),
      ),
    );
  }
}