import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/network/network_info.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/local_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/datasources/remote_data_source.dart';
import 'package:movie_app/src/features/popular_people/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/src/features/popular_people/domain/repositories/movie_repository.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_person_images_usecase.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_person_usecase.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_popular_people_usecase.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.I;

Future<void> initServiceLocator() async {
  //External Plugins
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => preferences);
  locator.registerLazySingleton(() => InternetConnectionChecker.instance);
  if (kDebugMode) {
    locator.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger());
    locator.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          contentType: 'application/json',
        ),
      )..interceptors.addAll([locator<PrettyDioLogger>()]),
    );
  } else {
    locator.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          contentType: 'application/json',
        ),
      ),
    );
  }

  //Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: locator()),
  );

  //UseCases
  locator.registerLazySingleton<GetPopularPeopleUseCase>(
    () => GetPopularPeopleUseCase(locator()),
  );
  locator.registerLazySingleton<GetPersonUseCase>(
    () => GetPersonUseCase(locator()),
  );
  locator.registerLazySingleton<GetPersonImageUseCase>(
    () => GetPersonImageUseCase(locator()),
  );

  //Repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      localDataSource: locator(),
      networkInfo: locator(),
      remoteDataSource: locator(),
    ),
  );

  //Data Sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(dio: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(preferences: locator()),
  );
}
