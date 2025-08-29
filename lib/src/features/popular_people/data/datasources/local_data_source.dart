import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:movie_app/src/core/constants/cache_keys.dart';
import 'package:movie_app/src/core/error/exceptions.dart';
import 'package:movie_app/src/features/popular_people/data/models/people_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieLocalDataSource {
  Future<PeoplePageModel> getPopularPeople();

  Future<Unit> cachePopularPeople(PeoplePageModel peoplePageModel);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences preferences;

  MovieLocalDataSourceImpl({required this.preferences});

  @override
  Future<Unit> cachePopularPeople(PeoplePageModel peoplePageModel) async {
    final jsonData = peoplePageModel.toMap();
    await preferences.setString(
      CacheKeys.cachePopularPeople,
      json.encode(jsonData),
    );
    return Future.value(unit);
  }

  @override
  Future<PeoplePageModel> getPopularPeople() {
    final jsonString = preferences.getString(CacheKeys.cachePopularPeople);
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      return Future.value(PeoplePageModel.fromMap(jsonData));
    } else {
      throw CacheException(message: 'No data in cache !');
    }
  }
}
