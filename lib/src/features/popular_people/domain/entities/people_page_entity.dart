import 'package:equatable/equatable.dart';

import 'person_entity.dart';

class PeoplePage extends Equatable {
  final int? page;
  final List<Person> results;
  final int? totalPages;
  final int? totalResults;

  const PeoplePage({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  PeoplePage copyWith({
    int? page,
    List<Person>? results,
    int? totalPages,
    int? totalResults,
  }) => PeoplePage(
    page: page ?? this.page,
    results: results ?? this.results,
    totalPages: totalPages ?? this.totalPages,
    totalResults: totalResults ?? this.totalResults,
  );

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
