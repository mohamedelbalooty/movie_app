import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/popular_people/cubit/popular_people_cubit.dart';
import 'package:movie_app/src/features/popular_people/presentation/pages/popular_people/widgets/popular_person_item_widget.dart';
import 'package:movie_app/src/features/popular_people/presentation/widgets/failure_widget.dart';
import 'package:movie_app/src/features/popular_people/presentation/widgets/loading_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('popular_people'.tr())),
      body: BlocBuilder<PopularPeopleCubit, PopularPeopleState>(
        builder: (context, state) {
          final cubit = PopularPeopleCubit.get(context);
          switch (state) {
            case PopularPeopleInitial():
            case PopularPeopleLoading():
              return const LoadingWidget();
            case PopularPeopleLoaded():
              return SmartRefresher(
                key: cubit.refreshKey,
                controller: cubit.refreshController,
                onRefresh: cubit.onRefresh,
                onLoading: cubit.onLoadMore,
                enablePullUp: true,
                enablePullDown: true,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, index) => PopularPersonItemWidget(
                    person: state.peoplePage.results[index],
                  ),
                  separatorBuilder: (_, index) => const SizedBox(height: 12),
                  itemCount: state.peoplePage.results.length,
                ),
              );
            case PopularPeopleFailed():
              return FailureWidget(
                message: state.message,
                onPressed: () => cubit.onInit(),
              );
          }
        },
      ),
    );
  }
}
