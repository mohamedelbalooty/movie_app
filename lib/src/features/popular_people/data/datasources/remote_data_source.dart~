import 'package:dio/dio.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/error/exceptions.dart';
import 'package:movie_app/src/features/popular_people/data/models/image_model.dart';
import 'package:movie_app/src/features/popular_people/data/models/people_page_model.dart';
import 'package:movie_app/src/features/popular_people/data/models/person_model.dart';

abstract class MovieRemoteDataSource {
  Future<PeoplePageModel> getPopularPeople({required int page});

  Future<PersonModel> getPerson({required String id});

  Future<List<ImageModel>> getPersonImages({required String id});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<PeoplePageModel> getPopularPeople({required int page}) async {
    try {
      final response = await dio.get(
        ApiConstants.popularPerson,
        queryParameters: {'api_key': ApiConstants.apiKey, 'page': 1},
      );
      final data = response.data as Map<String, dynamic>;
      return Future.value(PeoplePageModel.fromMap(data));
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server Error !');
    } catch (e) {
      throw DataException(message: e.toString());
    }
  }

  @override
  Future<PersonModel> getPerson({required String id}) async {
    try {
      final response = await dio.get(
        '${ApiConstants.person}/$id',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      final data = response.data as Map<String, dynamic>;
      return Future.value(PersonModel.fromMap(data));
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server Error !');
    } catch (e) {
      throw DataException(message: e.toString());
    }
  }

  @override
  Future<List<ImageModel>> getPersonImages({required String id}) async {
    try {
      final response = await dio.get(
        '${ApiConstants.person}/$id/images',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      final data = response.data as Map<String, dynamic>;
      final images = data['profiles'] as List<dynamic>;
      return Future.value(images.map((e) => ImageModel.fromMap(e)).toList());
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Server Error !');
    } catch (e) {
      throw DataException(message: e.toString());
    }
  }
}
