import 'package:equatable/equatable.dart';

class KnownForEntity extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  const KnownForEntity({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    voteAverage,
    voteCount,
  ];
}
