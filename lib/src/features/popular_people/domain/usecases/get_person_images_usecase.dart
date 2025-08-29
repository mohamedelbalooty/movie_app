import 'package:dartz/dartz.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';

class GetPersonImageUseCase {
  final MovieRepository repository;

  GetPersonImageUseCase(this.repository);

  Future<Either<Failure, List<Image>>> call({required String id}) async {
    return await repository.getPersonImages(id: id);
  }
}
