import 'package:equatable/equatable.dart';

import 'known_for_entity.dart';

class Person extends Equatable {
  final int? id;
  final int? gender;
  final String? name;
  final List<KnownForEntity> knownFor;

  const Person({this.id, this.gender, this.name, required this.knownFor});

  @override
  List<Object?> get props => [id, gender, name, knownFor];
}
