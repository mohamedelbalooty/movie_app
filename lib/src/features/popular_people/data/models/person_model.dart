import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';

import 'known_for_model.dart';

class PersonModel extends Person {
  final bool? adult;
  final String? knownForDepartment;
  final String? originalName;
  final double? popularity;
  final String? profilePath;

  const PersonModel({
    super.gender,
    super.id,
    this.adult,
    super.name,
    super.knownFor = const [],
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.profilePath,
  });

  factory PersonModel.fromMap(Map<String, dynamic> json) => PersonModel(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    knownFor: json["known_for"] == null
        ? []
        : List<KnownForModel>.from(
            json["known_for"]!.map((x) => KnownForModel.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "known_for": List<dynamic>.from(
      knownFor.map((x) => (x as KnownForModel).toMap()),
    ),
  };
}
