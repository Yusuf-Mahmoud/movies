// To parse this JSON data, do
//
//     final movieDetails = movieDetailsFromJson(jsonString);

import 'genre.dart';

class MovieDetails {
  String backdropPath;
  List<Genre> genres;
  int id;
  String overview;
  String posterPath;
  DateTime releaseDate;
  int runtime;
  String title;
  double voteAverage;

  MovieDetails({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        backdropPath: json["backdrop_path"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        runtime: json["runtime"],
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
