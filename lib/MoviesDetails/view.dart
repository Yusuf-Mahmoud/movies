import 'package:flutter/material.dart';
import 'package:movie_app/MoviesPorvider.dart';
import 'package:movie_app/core/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();

    var provider = Provider.of<MoviesProvider>(context, listen: false);

    provider.getMovieDetail().then(
          (value) => provider.getSimilarMovies(),
        );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MoviesProvider>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: AppColors().appBackground,
        appBar: AppBar(
          title: Text(
            provider.movieDetail?.title ?? 'Movie title',
            style: TextStyle(color: AppColors().white),
          ),
          backgroundColor: AppColors().appBackground,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors().white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              provider.movieDetailLoading
                  ? Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          AppColors().unSelectedNavigationBarItem,
                          AppColors().selectedNavigationBarItem,
                          AppColors().offWhite,
                        ],
                      ),
                      child: Container(
                        height: mediaQuery.size.height * 0.35,
                        width: double.infinity,
                        color: AppColors().darkGrey.withOpacity(0.5),
                      ),
                    )
                  : Container(
                      height: mediaQuery.size.height * 0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/original/${provider.movieDetail?.backdropPath ?? provider.movieDetail?.posterPath}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              provider.movieDetailLoading
                  ? Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          AppColors().unSelectedNavigationBarItem,
                          AppColors().selectedNavigationBarItem,
                          AppColors().offWhite,
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          'movie title',
                          style: TextStyle(
                            color: AppColors().offWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        provider.movieDetail?.title ?? 'movie',
                        style: TextStyle(
                          color: AppColors().offWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
              provider.movieDetailLoading
                  ? Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          AppColors().unSelectedNavigationBarItem,
                          AppColors().selectedNavigationBarItem,
                          AppColors().offWhite,
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                color: AppColors().offWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                color: AppColors().offWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            provider.convertString(
                              provider.movieDetail?.releaseDate.toString(),
                            ),
                            style: TextStyle(
                              color: AppColors().offWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            provider
                                .formatDuration(provider.movieDetail?.runtime),
                            style: TextStyle(
                              color: AppColors().offWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
              provider.movieDetailLoading
                  ? Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          AppColors().unSelectedNavigationBarItem,
                          AppColors().selectedNavigationBarItem,
                          AppColors().offWhite,
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: mediaQuery.size.height * 0.2,
                                width: mediaQuery.size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original/${provider.movieDetail?.posterPath}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: mediaQuery.size.height * 0.06,
                                    child: GridView.builder(
                                      itemCount: 3,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 3,
                                        childAspectRatio: 3 / 1.5,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color: AppColors().offWhite,
                                            ),
                                          ),
                                          child: Text(
                                            'genre',
                                            style: TextStyle(
                                              color: AppColors().offWhite,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediaQuery.size.height * 0.1,
                                    child: Text(
                                      'overview',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors().offWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediaQuery.size.height * 0.04,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColors()
                                              .selectedNavigationBarItem,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'genre',
                                          style: TextStyle(
                                            color: AppColors().offWhite,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: mediaQuery.size.height * 0.2,
                            width: mediaQuery.size.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/original/${provider.movieDetail?.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: mediaQuery.size.height * 0.06,
                                child: GridView.builder(
                                  itemCount:
                                      provider.movieDetail?.genres?.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    childAspectRatio: 3 / 1.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors().offWhite,
                                        ),
                                      ),
                                      child: Text(
                                        provider.movieDetail?.genres?[index]
                                                .name ??
                                            'genre',
                                        style: TextStyle(
                                          color: AppColors().offWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.size.height * 0.1,
                                child: Text(
                                  provider.movieDetail?.overview ?? 'overview',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors().offWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.size.height * 0.04,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color:
                                          AppColors().selectedNavigationBarItem,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      double.parse(
                                        provider.movieDetail!.voteAverage
                                            .toString(),
                                      ).toStringAsFixed(1),
                                      style: TextStyle(
                                        color: AppColors().offWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              provider.similarMoviesLoading
                  ? Container(
                      color: AppColors().darkGrey,
                      height: mediaQuery.size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'More Like This',
                              style: TextStyle(
                                color: AppColors().offWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Shimmer(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors().unSelectedNavigationBarItem,
                                    AppColors().selectedNavigationBarItem,
                                    AppColors().offWhite,
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: mediaQuery.size.height * 0.2,
                                        width: mediaQuery.size.width * 0.3,
                                        decoration: BoxDecoration(
                                          color: AppColors().darkGrey,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(8),
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: AppColors()
                                                .selectedNavigationBarItem,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '0.0',
                                            style: TextStyle(
                                              color: AppColors().white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.3,
                                        child: Text(
                                          'Movie Title',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors().white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.3,
                                        child: Text(
                                          '2021',
                                          style: TextStyle(
                                            color: AppColors().white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: AppColors().darkGrey,
                      height: mediaQuery.size.height * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'More Like This',
                              style: TextStyle(
                                color: AppColors().offWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: provider.similarMovies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  provider.setMovieDetailsIndex(
                                    provider.similarMovies[index].id,
                                  );
                                  Navigator.pop(context);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MovieDetails(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: mediaQuery.size.height * 0.2,
                                        width: mediaQuery.size.width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://image.tmdb.org/t/p/original/${provider.similarMovies[index].posterPath ?? provider.similarMovies[index].backdropPath}',
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
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(8),
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: AppColors()
                                                .selectedNavigationBarItem,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            double.parse(
                                              provider.similarMovies[index]
                                                  .voteAverage
                                                  .toString(),
                                            ).toStringAsFixed(1),
                                            style: TextStyle(
                                              color: AppColors().white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.3,
                                        child: Text(
                                          provider.similarMovies[index].title ??
                                              'movie',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors().white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.3,
                                        child: Text(
                                          provider.convertString(
                                            provider.similarMovies[index]
                                                .releaseDate,
                                          ),
                                          style: TextStyle(
                                            color: AppColors().white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}