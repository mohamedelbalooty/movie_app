import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/people_page_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_popular_people_usecase.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

part 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  final GetPopularPeopleUseCase popularPeopleUseCase;
  final refreshKey = GlobalKey();
  final refreshController = RefreshController();

  PopularPeopleCubit({required this.popularPeopleUseCase})
    : super(PopularPeopleInitial());

  static PopularPeopleCubit get(context) => BlocProvider.of(context);

  int _page = 1;

  Future<void> _getPopularPeople({bool isLoadMore = false}) async {
    if (!isLoadMore) emit(PopularPeopleLoading());
    final result = await popularPeopleUseCase.call(page: _page);
    result.fold(
      (failure) => emit(PopularPeopleFailed(message: failure.message)),
      (peoplePage) {
        if (isLoadMore && state is PopularPeopleLoaded) {
          final current = (state as PopularPeopleLoaded).peoplePage;
          final merged = current.copyWith(
            results: [...current.results, ...peoplePage.results],
            totalPages: peoplePage.totalPages,
          );
          print(merged.results.length);
          emit(PopularPeopleLoaded(peoplePage: merged));
        } else {
          emit(PopularPeopleLoaded(peoplePage: peoplePage));
        }
      },
    );
  }

  void onInit() async {
    _page = 1;
    await _getPopularPeople();
  }

  void onRefresh() async {
    _page = 1;
    await _getPopularPeople();
    refreshController.refreshCompleted();
  }

  void onLoadMore() async {
    if (state is PopularPeopleLoaded) {
      final currentState = state as PopularPeopleLoaded;
      if (_page < (currentState.peoplePage.totalPages ?? 1)) {
        _page++;
        await _getPopularPeople(isLoadMore: true);
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } else {
      return;
    }
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}
