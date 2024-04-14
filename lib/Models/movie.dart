
class Movie {
  final int? id;
  final String? title;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;

  Movie({
    this.id,
    this.backdropPath,
    this.title,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? json['backdrop_path'],
      releaseDate: json['release_date'] ?? '',
      id: json['id'] ?? '',
      backdropPath: json['backdrop_path'] ?? json['poster_path'],
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
    );
  }
}
