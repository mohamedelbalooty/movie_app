import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/error/failures.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_person_images_usecase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPersonImageUseCase usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetPersonImageUseCase(mockRepository);
  });

  const tId = '123';
  final tImages = [const Image(filePath: '/test.jpg')];

  test('should return List<Image> from repository when successful', () async {
    when(
      () => mockRepository.getPersonImages(id: tId),
    ).thenAnswer((_) async => Right(tImages));
    final result = await usecase(id: tId);
    expect(result, Right(tImages));
    verify(() => mockRepository.getPersonImages(id: tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when repository fails', () async {
    when(
      () => mockRepository.getPersonImages(id: tId),
    ).thenAnswer((_) async => const Left(ServerFailure(message: 'Error')));
    final result = await usecase(id: tId);
    expect(result, const Left(ServerFailure(message: 'Error')));
    verify(() => mockRepository.getPersonImages(id: tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
