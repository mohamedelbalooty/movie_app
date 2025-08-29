import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit() : super(PersonDetailsInitial());

  static PersonDetailsCubit get(context) => BlocProvider.of(context);
}
