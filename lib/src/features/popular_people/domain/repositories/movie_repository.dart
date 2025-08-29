import 'package:dartz/dartz.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, PeoplePage>> getPopularPeople({required int page});

  Future<Either<Failure, Person>> getPerson({required String id});

  Future<Either<Failure, List<Image>>> getPersonImages({required String id});
}
