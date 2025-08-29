import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  PopularPeopleCubit() : super(PopularPeopleInitial());

  static PopularPeopleCubit get(context) => BlocProvider.of(context);
}
