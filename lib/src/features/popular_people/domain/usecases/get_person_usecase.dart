import 'package:dartz/dartz.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';

class GetPersonUseCase {
  final MovieRepository repository;

  GetPersonUseCase(this.repository);

  Future<Either<Failure, Person>> call({required String id}) async {
    return await repository.getPerson(id: id);
  }
}
