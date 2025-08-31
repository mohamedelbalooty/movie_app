import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  const tPage = 1;
  const tId = '123';

  final tPeoplePage = const PeoplePage(
    page: 1,
    results: [],
    totalPages: 1,
    totalResults: 0,
  );

  final tPerson = const Person(id: 1, name: 'John Doe', knownFor: []);
  final tImages = [const Image(filePath: '/test.jpg')];

  group('MovieRepository contract', () {
    test('getPopularPeople should return Right(PeoplePage)', () async {
      when(
        () => mockRepository.getPopularPeople(page: tPage),
      ).thenAnswer((_) async => Right(tPeoplePage));
      final result = await mockRepository.getPopularPeople(page: tPage);

      expect(result, Right(tPeoplePage));
      verify(() => mockRepository.getPopularPeople(page: tPage)).called(1);
    });

    test('getPerson should return Right(Person)', () async {
      when(
        () => mockRepository.getPerson(id: tId),
      ).thenAnswer((_) async => Right(tPerson));
      final result = await mockRepository.getPerson(id: tId);
      expect(result, Right(tPerson));
      verify(() => mockRepository.getPerson(id: tId)).called(1);
    });

    test('getPersonImages should return Right(List<Image>)', () async {
      when(
        () => mockRepository.getPersonImages(id: tId),
      ).thenAnswer((_) async => Right(tImages));
      final result = await mockRepository.getPersonImages(id: tId);
      expect(result, Right(tImages));
      verify(() => mockRepository.getPersonImages(id: tId)).called(1);
    });

    test('getPopularPeople should return Left(Failure) when error', () async {
      when(
        () => mockRepository.getPopularPeople(page: tPage),
      ).thenAnswer((_) async => const Left(ServerFailure(message: 'Error')));
      final result = await mockRepository.getPopularPeople(page: tPage);
      expect(result, const Left(ServerFailure(message: 'Error')));
    });
  });
}
