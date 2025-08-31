import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/error/exceptions.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/remote_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/models/image_model.dart';
import 'package:movie_app/src/features/popular_people/data/models/people_page_model.dart';
import 'package:movie_app/src/features/popular_people/data/models/person_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = MovieRemoteDataSourceImpl(dio: mockDio);
  });

  group('getPopularPeople', () {
    final tResponseData = const PeoplePageModel(
      page: 1,
      results: [],
      totalPages: 1,
      totalResults: 0,
    ).toMap();

    test('should return PeoplePageModel when request is successful', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseData,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await dataSource.getPopularPeople(page: 1);

      expect(result, isA<PeoplePageModel>());
    });

    test('should throw ServerException on DioException', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          message: 'Error',
        ),
      );
      final call = dataSource.getPopularPeople;
      expect(() => call(page: 1), throwsA(isA<ServerException>()));
    });
  });

  group('getPerson', () {
    final tPersonData = const PersonModel(
      id: 1,
      name: 'Test Person',
      popularity: 10.0,
      profilePath: '/path.jpg',
    ).toMap();

    test('should return PersonModel on success', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tPersonData,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );
      final result = await dataSource.getPerson(id: '1');
      expect(result, isA<PersonModel>());
    });
  });

  group('getPersonImages', () {
    final tImageList = [
      const ImageModel(
        filePath: '/test.jpg',
        aspectRatio: 1.0,
        height: 100,
        width: 100,
      ).toMap(),
    ];

    test('should return List<ImageModel> on success', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: {'profiles': tImageList},
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );
      final result = await dataSource.getPersonImages(id: '1');
      expect(result, isA<List<ImageModel>>());
      expect(result.length, 1);
    });
  });
}
