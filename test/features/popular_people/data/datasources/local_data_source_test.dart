import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/core/constants/cache_keys.dart';
import 'package:movie_app/src/core/error/exceptions.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/local_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/models/people_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    dataSource = MovieLocalDataSourceImpl(preferences: mockPrefs);
  });

  final tPeoplePageModel = const PeoplePageModel(
    page: 1,
    results: [],
    totalPages: 1,
    totalResults: 0,
  );

  group('cachePopularPeople', () {
    test('should call SharedPreferences to cache data', () async {
      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);
      await dataSource.cachePopularPeople(tPeoplePageModel);
      verify(
        () => mockPrefs.setString(
          CacheKeys.cachePopularPeople,
          json.encode(tPeoplePageModel.toMap()),
        ),
      ).called(1);
    });
  });

  group('getPopularPeople', () {
    test('should return PeoplePageModel when cache exists', () async {
      when(
        () => mockPrefs.getString(CacheKeys.cachePopularPeople),
      ).thenReturn(json.encode(tPeoplePageModel.toMap()));
      final result = await dataSource.getPopularPeople();
      expect(result, equals(tPeoplePageModel));
    });
    test('should throw CacheException when cache does not exist', () async {
      when(
        () => mockPrefs.getString(CacheKeys.cachePopularPeople),
      ).thenReturn(null);
      final call = dataSource.getPopularPeople;
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
