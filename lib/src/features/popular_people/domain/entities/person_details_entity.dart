import 'package:equatable/equatable.dart';

class PersonDetails extends Equatable {
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final String? profilePath;
  final DateTime? birthday;

  const PersonDetails({
    this.id,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.profilePath,
    this.birthday,
  });

  @override
  List<Object?> get props => [
    id,
    knownForDepartment,
    name,
    placeOfBirth,
    profilePath,
    birthday,
  ];
}
