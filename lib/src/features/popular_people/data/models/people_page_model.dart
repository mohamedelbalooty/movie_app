import 'package:movie_app/src/features/popular_people/data/models/person_model.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';

class PeoplePageModel extends PeoplePage {
  const PeoplePageModel({
    super.page,
    super.results = const [],
    super.totalPages,
    super.totalResults,
  });

  factory PeoplePageModel.fromMap(Map<String, dynamic> json) => PeoplePageModel(
    page: json['page'],
    results: List<PersonModel>.from(
      json['results'].map((x) => PersonModel.fromMap(x)),
    ),
    totalPages: json['total_pages'],
    totalResults: json['total_results'],
  );

  Map<String, dynamic> toMap() => {
    'page': page,
    'results': List<dynamic>.from(
      results.map((x) => (x as PersonModel).toMap()),
    ),
    'total_pages': totalPages,
    'total_results': totalResults,
  };
}
