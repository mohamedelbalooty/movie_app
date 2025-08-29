import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/navigation/app_router.dart';

import 'core/utils/app_theme.dart' show AppTheme;

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.appTheme,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: widget!,
          );
        },
        routerConfig: AppRouter.router,
      ),
    );
  }
}
