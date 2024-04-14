import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Models/movie.dart';
import 'package:movie_app/Models/movie_details.dart';
import 'package:movie_app/MoviesBaseScreen/view.dart';
import 'package:movie_app/MoviesCategories/view.dart';
import 'package:movie_app/MoviesHome/view.dart';
import 'package:movie_app/MoviesSearch/view.dart';
import 'package:movie_app/MoviesWatchList/view.dart';
import 'package:movie_app/core/constants.dart';

class MoviesProvider extends ChangeNotifier {
  //splash
  splashTimer(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MoviesBase()),
      );
      notifyListeners();
    });
  }

  //baseScreen

  int _screenIndex = 0;
  get screenIndex => _screenIndex;

  setScreenIndex(int index) {
    _screenIndex = index;
    _pageController.jumpToPage(index);
    notifyListeners();
  }

  final List<Widget> _screens = [
    MoviesHome(),
    const MoviesSearch(),
    const MoviesCategories(),
    const MoviesWatchlist(),
  ];

  get screens => _screens;

  final PageController _pageController = PageController();
  get pageController => _pageController;

  List<Movie> _popularMovies = [];
  get popularMovies => _popularMovies;

  List<Movie> _newReleasesMovies = [];
  get newReleasesMovies => _newReleasesMovies;

  List<Movie> _recommendedMovies = [];
  get recommendedMovies => _recommendedMovies;

  Dio dio = Dio();

  int _randomPopularMovie = 0;
  get randomPopularMovie => _randomPopularMovie;

  setRandomPopularMovie() {
    _randomPopularMovie = Random().nextInt(_popularMovies.length);
    notifyListeners();
  }

  String convertString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return date.year.toString();
  }

  bool _popularMoviesLoading = true;
  get popularMoviesLoading => _popularMoviesLoading;

  bool _newReleasesMoviesLoading = true;
  get newReleasesMoviesLoading => _newReleasesMoviesLoading;

  bool _recommendedMoviesLoading = true;
  get recommendedMoviesLoading => _recommendedMoviesLoading;

  int _movieDetailsIndex = 0;
  get movieDetailsIndex => _movieDetailsIndex;

  Future<void> setMovieDetailsIndex(int val) async {
    _movieDetailsIndex = val;
    notifyListeners();
  }

  String formatDuration(int minutes) {
    if (minutes < 0) {
      throw ArgumentError('Duration must be a non-negative integer.');
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    String hoursString = hours > 0 ? '${hours}h ' : '';
    String minutesString = remainingMinutes > 0 ? '${remainingMinutes}m' : '';

    return hoursString + minutesString;
  }

  MovieDetails? _movieDetail;
  get movieDetail => _movieDetail;

  bool _movieDetailLoading = true;
  get movieDetailLoading => _movieDetailLoading;

  Future<void> getMovieDetail() async {
    _movieDetailLoading = true;

    print(_movieDetailsIndex);
    await dio
        .get(
            'https://api.themoviedb.org/3/movie/${_movieDetailsIndex}?api_key=${AppConstants.api_key}')
        .then((value) {
          _movieDetail = MovieDetails.fromJson(value.data);
        })
        .then((value) => _movieDetailLoading = false)
        .then((value) => notifyListeners());
  }

  Future<void> getPopularMovies() async {
    _popularMoviesLoading = true;
    // notifyListeners();
    await dio
        .get(
          'https://api.themoviedb.org/3/movie/popular?api_key=${AppConstants.api_key}&language=en-US&page=1',
        )
        .then((value) {
          _popularMovies = (value.data['results'] as List)
              .map((e) => Movie.fromJson(e))
              .toList();
        })
        .then((value) => setRandomPopularMovie())
        .then((value) => _popularMoviesLoading = false)
        .then((value) => notifyListeners());
  }

  Future<void> getNewReleasesMovies() async {
    _newReleasesMoviesLoading = true;
    notifyListeners();
    await dio
        .get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=${AppConstants.api_key}&language=en-US&page=1',
        )
        .then((value) {
          _newReleasesMovies = (value.data['results'] as List)
              .map((e) => Movie.fromJson(e))
              .toList();
        })
        .then((value) => _newReleasesMoviesLoading = false)
        .then((value) => notifyListeners());
  }

  Future<void> getRecommendedMovies() async {
    _recommendedMoviesLoading = true;
    notifyListeners();
    await dio
        .get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=${AppConstants.api_key}&language=en-US&page=1',
        )
        .then((value) {
          _recommendedMovies = (value.data['results'] as List)
              .map((e) => Movie.fromJson(e))
              .toList();
        })
        .then((value) => _recommendedMoviesLoading = false)
        .then((value) => notifyListeners());
  }
}
