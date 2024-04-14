import 'package:flutter/material.dart';
import 'package:movie_app/MoviesPorvider.dart';
import 'package:movie_app/core/colors.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatefulWidget {
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();

    Provider.of<MoviesProvider>(context, listen: false).getMovieDetail();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MoviesProvider>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: AppColors().appBackground,
        appBar: AppBar(
          title: Text(
            provider.movieDetail.title,
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
              Container(
                height: mediaQuery.size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/original/${provider.movieDetail.backdropPath ?? provider.movieDetail.posterPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  provider.movieDetail.title,
                  style: TextStyle(
                    color: AppColors().white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      provider.convertString(
                        provider.movieDetail.releaseDate.toString(),
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
                      provider.formatDuration(provider.movieDetail.runtime),
                      style: TextStyle(
                        color: AppColors().offWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
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
                            'https://image.tmdb.org/t/p/original/${provider.movieDetail.posterPath}',
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
                        Container(
                            height: mediaQuery.size.height * 0.06,
                            child: GridView.builder(
                                itemCount: provider.movieDetail.genres.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: 3 / 1.5),
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors().offWhite,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        provider.movieDetail.genres[index].name,
                                        style: TextStyle(
                                          color: AppColors().offWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ));
                                })),
                        Container(
                          height: mediaQuery.size.height * 0.1,
                          child: Text(
                            provider.movieDetail.overview,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors().offWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          height: mediaQuery.size.height * 0.04,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors().selectedNavigationBarItem,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                double.parse(provider.movieDetail.voteAverage
                                        .toString())
                                    .toStringAsFixed(1),
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
              Container(
                  color: AppColors().darkGrey,
                  height: mediaQuery.size.height * 0.1,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container())),
            ],
          ),
        ),
      ),
    );
  }
}
