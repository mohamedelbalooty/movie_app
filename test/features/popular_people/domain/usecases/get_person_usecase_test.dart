import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_person_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPersonUseCase usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetPersonUseCase(mockRepository);
  });

  const tId = '123';
  final tPerson = const Person(id: 1, name: 'John Doe', knownFor: []);

  test('should return Person from repository when successful', () async {
    when(
      () => mockRepository.getPerson(id: tId),
    ).thenAnswer((_) async => Right(tPerson));
    final result = await usecase(id: tId);
    expect(result, Right(tPerson));
    verify(() => mockRepository.getPerson(id: tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    when(
      () => mockRepository.getPerson(id: tId),
    ).thenAnswer((_) async => const Left(ServerFailure(message: 'Error')));
    final result = await usecase(id: tId);
    expect(result, const Left(ServerFailure(message: 'Error')));
    verify(() => mockRepository.getPerson(id: tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
