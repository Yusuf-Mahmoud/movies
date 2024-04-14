class Genre {
  String name;

  Genre({
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
