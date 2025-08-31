import 'package:equatable/equatable.dart';

import 'known_for_entity.dart';

class Person extends Equatable {
  final int? id;
  final int? gender;
  final String? name;
  final String? knownForDepartment;
  final String? profilePath;
  final List<KnownForEntity> knownFor;

  const Person({
    this.id,
    this.gender,
    this.name,
    this.knownForDepartment,
    this.profilePath,
    required this.knownFor,
  });

  @override
  List<Object?> get props => [
    id,
    gender,
    name,
    profilePath,
    knownForDepartment,
    knownFor,
  ];
}
