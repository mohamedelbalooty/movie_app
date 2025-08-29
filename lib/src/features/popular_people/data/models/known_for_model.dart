import 'package:movie_app/src/features/popular_people/domain/entities/known_for_entity.dart';

class KnownForModel extends KnownForEntity {
  final bool? adult;
  final String? backdropPath;
  final String? originalTitle;
  final String? mediaType;
  final String? originalLanguage;
  final List<int> genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? video;
  final String? name;
  final String? originalName;
  final DateTime? firstAirDate;
  final List<String> originCountry;

  const KnownForModel({
    super.id,
    super.title,
    super.overview,
    super.posterPath,
    super.voteAverage,
    super.voteCount,
    this.adult,
    this.backdropPath,
    this.originalTitle,
    this.mediaType,
    this.originalLanguage,
    this.genreIds = const [],
    this.popularity,
    this.releaseDate,
    this.video,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry = const [],
  });

  factory KnownForModel.fromMap(Map<String, dynamic> json) => KnownForModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: json["media_type"],
    originalLanguage: json["original_language"],
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"]!.map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    releaseDate: json["release_date"] == null
        ? null
        : DateTime.parse(json["release_date"]),
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
    firstAirDate: json["first_air_date"] == null
        ? null
        : DateTime.parse(json["first_air_date"]),
    originCountry: json["origin_country"] == null
        ? []
        : List<String>.from(json["origin_country"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType,
    "original_language": originalLanguage,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "release_date":
        "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "name": name,
    "original_name": originalName,
    "first_air_date":
        "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
  };
}
