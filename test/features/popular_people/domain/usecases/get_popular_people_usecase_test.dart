import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_popular_people_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPopularPeopleUseCase usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetPopularPeopleUseCase(mockRepository);
  });

  const tPage = 1;
  final tPeoplePage = const PeoplePage(
    page: 1,
    results: [],
    totalPages: 1,
    totalResults: 0,
  );

  test('should return PeoplePage from repository when successful', () async {
    when(
      () => mockRepository.getPopularPeople(page: tPage),
    ).thenAnswer((_) async => Right(tPeoplePage));
    final result = await usecase(page: tPage);
    expect(result, Right(tPeoplePage));
    verify(() => mockRepository.getPopularPeople(page: tPage)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    when(
      () => mockRepository.getPopularPeople(page: tPage),
    ).thenAnswer((_) async => const Left(ServerFailure(message: 'Error')));
    final result = await usecase(page: tPage);
    expect(result, const Left(ServerFailure(message: 'Error')));
    verify(() => mockRepository.getPopularPeople(page: tPage)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
