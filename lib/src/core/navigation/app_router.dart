import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/core/navigation/app_routes.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/person_details/cubit/person_details_cubit.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/person_details/person_details_page.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/popular_people/cubit/popular_people_cubit.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/popular_people/popular_people_page.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/show_image/cubit/show_image_cubit.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/show_image/show_image_page.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.popularPeople,
    routes: [
      GoRoute(
        path: AppRoutes.popularPeople,
        builder: (context, state) => BlocProvider(
          create: (_) => PopularPeopleCubit(),
          child: const PopularPeoplePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.personDetails,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => PersonDetailsCubit(),
            child: const PersonDetailsPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.imageDetails,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ShowImageCubit(),
            child: ShowImagePage(),
          );
        },
      ),
    ],
  );
}
