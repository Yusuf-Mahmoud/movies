import 'package:flutter/material.dart';
import 'package:movie_app/MoviesPorvider.dart';
import 'package:movie_app/core/colors.dart';
import 'package:provider/provider.dart';

class MoviesSplash extends StatefulWidget {
  const MoviesSplash({super.key});

  @override
  State<MoviesSplash> createState() => _MoviesSplashState();
}

class _MoviesSplashState extends State<MoviesSplash> {
  @override
  initState() {
    super.initState();

    var provider = Provider.of<MoviesProvider>(context, listen: false);
    provider.splashTimer(context);

    provider
        .getPopularMovies()
        .then((value) => provider.getNewReleasesMovies())
        .then((value) => provider.getRecommendedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appBackground,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Image.asset(
              'assets/images/logo.png',
              scale: 1,
            ),
            Image.asset(
              'assets/images/merchant.png',
              scale: 1,
            ),
          ],
        ),
      ),
    );
  }
}
