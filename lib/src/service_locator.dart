import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/src/core/constants/api_constants.dart';
import 'package:movie_app/src/core/network/network_info.dart';
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
}
