
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
  int get screenIndex => _screenIndex;

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

  List<Widget> get screens => _screens;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  List<Movie> _popularMovies = [];
  List<Movie> get popularMovies => _popularMovies;

  List<Movie> _newReleasesMovies = [];
  List<Movie> get newReleasesMovies => _newReleasesMovies;

  List<Movie> _recommendedMovies = [];
  List<Movie> get recommendedMovies => _recommendedMovies;

  Dio dio = Dio();

  int _randomPopularMovie = 0;
  int get randomPopularMovie => _randomPopularMovie;

  setRandomPopularMovie() {
    _randomPopularMovie = Random().nextInt(_popularMovies.length);
    notifyListeners();
  }

  String convertString(String? dateString) {
    if (dateString == null) {
      return '';
    }
    DateTime date = DateTime.parse(dateString);
    return date.year.toString();
  }

  bool _popularMoviesLoading = true;
  bool get popularMoviesLoading => _popularMoviesLoading;

  bool _newReleasesMoviesLoading = true;
  bool get newReleasesMoviesLoading => _newReleasesMoviesLoading;

  bool _recommendedMoviesLoading = true;
  bool get recommendedMoviesLoading => _recommendedMoviesLoading;

  int _movieDetailsIndex = 0;
  int get movieDetailsIndex => _movieDetailsIndex;

  Future<void> setMovieDetailsIndex(int? val) async {
    if (val == null) {
      return;
    }

    _movieDetailsIndex = val;
    notifyListeners();
  }

  String formatDuration(int? minutes) {
    if (minutes == null) {
      return '';
    }
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
  MovieDetails? get movieDetail => _movieDetail;

  bool _movieDetailLoading = true;
  bool get movieDetailLoading => _movieDetailLoading;

  Future<void> getMovieDetail() async {
    _movieDetailLoading = true;

    await dio
        .get(
          'https://api.themoviedb.org/3/movie/$_movieDetailsIndex?api_key=${AppConstants.apiKey}',
        )
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
          'https://api.themoviedb.org/3/movie/popular?api_key=${AppConstants.apiKey}&language=en-US&page=1',
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
          'https://api.themoviedb.org/3/movie/upcoming?api_key=${AppConstants.apiKey}&language=en-US&page=1',
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
          'https://api.themoviedb.org/3/movie/top_rated?api_key=${AppConstants.apiKey}&language=en-US&page=1',
        )
        .then((value) {
          _recommendedMovies = (value.data['results'] as List)
              .map((e) => Movie.fromJson(e))
              .toList();
        })
        .then((value) => _recommendedMoviesLoading = false)
        .then((value) => notifyListeners());
  }

  List<Movie> _similarMovies = [];
  List<Movie> get similarMovies => _similarMovies;

  bool _similarMoviesLoading = true;
  bool get similarMoviesLoading => _similarMoviesLoading;
  Future<void> getSimilarMovies() async {
    _similarMoviesLoading = true;
    await dio
        .get(
          'https://api.themoviedb.org/3/movie/$_movieDetailsIndex/similar?api_key=${AppConstants.apiKey}&language=en-US&page=1',
        )
        .then((value) {
          //CHECK IF THE MOVIE HAS SIMILAR MOVIES
          if (value.data['results'] == null ||
              value.data['results'].length == 0) {
            _similarMovies = [];
            notifyListeners();
            return;
          }
          _similarMovies = (value.data['results'] as List)
              .map((e) => Movie.fromJson(e))
              .toList();
        })
        .then((value) => _similarMoviesLoading = false)
        .then((value) => notifyListeners());
  }
}
