import 'package:flutter/material.dart';
import 'package:movie_app/MoviesDetails/view.dart';
import 'package:movie_app/MoviesPorvider.dart';
import 'package:movie_app/core/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MoviesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MoviesProvider>(
      builder: (BuildContext context, provider, Widget? child) =>
          SingleChildScrollView(
        child: Column(
          children: [
            provider.popularMoviesLoading
                ? SizedBox(
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.4,
                    child: Stack(
                      children: [
                        Container(
                          height: mediaQuery.size.height * 0.32,
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Shimmer(
                            gradient: LinearGradient(
                              colors: [
                                AppColors().unSelectedNavigationBarItem,
                                AppColors().selectedNavigationBarItem,
                                AppColors().offWhite,
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors().darkGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: mediaQuery.size.width * .3,
                              height: mediaQuery.size.height * 0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors().white,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: mediaQuery.size.height * 0.32 + 5,
                          left: mediaQuery.size.width * .3 + 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "name of movie",
                                style: TextStyle(
                                  color: AppColors().white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "2020",
                                style: TextStyle(
                                  color: AppColors().offWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.4,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider
                                .setMovieDetailsIndex(
                                  provider
                                      .popularMovies[
                                          provider.randomPopularMovie]
                                      .id,
                                )
                                .then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetails(),
                                    ),
                                  ),
                                );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/original/${provider.popularMovies[provider.randomPopularMovie ?? 0].backdropPath ?? provider.popularMovies[provider.randomPopularMovie].posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: mediaQuery.size.height * 0.32,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/original/${provider.popularMovies[provider.randomPopularMovie].posterPath ?? provider.popularMovies[provider.randomPopularMovie].backdropPath}',
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: mediaQuery.size.width * .3,
                            height: mediaQuery.size.height * 0.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors().white,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: mediaQuery.size.height * 0.32 + 5,
                          left: mediaQuery.size.width * .3 + 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider
                                    .popularMovies[provider.randomPopularMovie]
                                    .title,
                                style: TextStyle(
                                  color: AppColors().white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                provider.convertString(
                                  provider
                                      .popularMovies[
                                          provider.randomPopularMovie]
                                      .releaseDate,
                                ),
                                style: TextStyle(
                                  color: AppColors().offWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            provider.newReleasesMoviesLoading
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.2,
                    color: AppColors().darkGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Releases',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors().white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Shimmer(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors().unSelectedNavigationBarItem,
                                    AppColors().selectedNavigationBarItem,
                                    AppColors().offWhite,
                                  ],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: mediaQuery.size.width * 0.25,
                                  height: mediaQuery.size.height * 0.25,
                                  decoration: BoxDecoration(
                                    color: AppColors().darkGrey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors().white,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.2,
                    color: AppColors().darkGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Releases',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors().white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.newReleasesMovies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  provider
                                      .setMovieDetailsIndex(
                                        provider.newReleasesMovies[index].id,
                                      )
                                      .then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetails(),
                                          ),
                                        ),
                                      );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: mediaQuery.size.width * 0.25,
                                  height: mediaQuery.size.height * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/original/${provider.newReleasesMovies[index].posterPath}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors().white,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            provider.recommendedMoviesLoading
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.25,
                    color: AppColors().darkGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors().white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Shimmer(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors().unSelectedNavigationBarItem,
                                    AppColors().selectedNavigationBarItem,
                                    AppColors().offWhite,
                                  ],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: mediaQuery.size.width * 0.25,
                                  height: mediaQuery.size.height * 0.25,
                                  decoration: BoxDecoration(
                                    color: AppColors().darkGrey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors().white,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: mediaQuery.size.height * 0.25,
                    color: AppColors().darkGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors().white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.recommendedMovies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  provider
                                      .setMovieDetailsIndex(
                                        provider.recommendedMovies[index].id,
                                      )
                                      .then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetails(),
                                          ),
                                        ),
                                      );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: mediaQuery.size.width * 0.25,
                                  height: mediaQuery.size.height * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/original/${provider.recommendedMovies[index].posterPath}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors().white,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
