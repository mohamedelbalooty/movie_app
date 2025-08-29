import 'package:dartz/dartz.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';

class GetPopularPeopleUseCase {
  final MovieRepository repository;

  GetPopularPeopleUseCase(this.repository);

  Future<Either<Failure, PeoplePage>> call({required int page}) async {
    return await repository.getPopularPeople(page: page);
  }
}
