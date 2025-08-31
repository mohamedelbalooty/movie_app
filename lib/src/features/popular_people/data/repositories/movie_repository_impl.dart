import 'package:dartz/dartz.dart';
import 'package:movie_app/src/core/error/exceptions.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/core/network/network_info.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/local_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/remote_data_source.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PeoplePage>> getPopularPeople({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final peoplePage = await remoteDataSource.getPopularPeople(page: page);
        await localDataSource.cachePopularPeople(peoplePage);
        return Right(peoplePage);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(DataFailure(message: e.toString()));
      }
    } else {
      try {
        final cachedPosts = await localDataSource.getPopularPeople();
        return Right(cachedPosts);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Person>> getPerson({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final person = await remoteDataSource.getPerson(id: id);
        return Right(person);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(DataFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection !'));
    }
  }

  @override
  Future<Either<Failure, List<Image>>> getPersonImages({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final person = await remoteDataSource.getPersonImages(id: id);
        return Right(person);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(DataFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection !'));
    }
  }
}
