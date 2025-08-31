import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/error/exceptions.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/core/network/network_info.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/local_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/remote_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/models/people_page_model.dart';
import 'package:movie_app/src/features/popular_people/data/repositories/movie_repository_impl.dart';

class MockRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockLocalDataSource extends Mock implements MovieLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MovieRepositoryImpl repository;
  late MockRemoteDataSource mockRemote;
  late MockLocalDataSource mockLocal;
  late MockNetworkInfo mockNetwork;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    mockLocal = MockLocalDataSource();
    mockNetwork = MockNetworkInfo();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
      networkInfo: mockNetwork,
    );
  });

  final tPeoplePageModel = const PeoplePageModel(
    page: 1,
    results: [],
    totalPages: 1,
    totalResults: 0,
  );

  group('getPopularPeople', () {
    test('should return remote data when online', () async {
      when(() => mockNetwork.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemote.getPopularPeople(page: 1),
      ).thenAnswer((_) async => tPeoplePageModel);
      when(
        () => mockLocal.cachePopularPeople(any()),
      ).thenAnswer((_) async => unit);
      final result = await repository.getPopularPeople(page: 1);
      expect(result, Right(tPeoplePageModel));
      verify(() => mockRemote.getPopularPeople(page: 1)).called(1);
    });

    test('should return cached data when offline', () async {
      when(() => mockNetwork.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocal.getPopularPeople(),
      ).thenAnswer((_) async => tPeoplePageModel);
      final result = await repository.getPopularPeople(page: 1);
      expect(result, Right(tPeoplePageModel));
      verify(() => mockLocal.getPopularPeople()).called(1);
    });

    test('should return CacheFailure when offline and no cache', () async {
      when(() => mockNetwork.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocal.getPopularPeople(),
      ).thenThrow(CacheException(message: 'No cache'));
      final result = await repository.getPopularPeople(page: 1);
      expect(result, const Left(CacheFailure(message: 'No cache')));
    });
  });
}
