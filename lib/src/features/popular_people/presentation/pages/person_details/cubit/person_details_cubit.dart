import 'package:flutter/material.dart' hide Image;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_app/src/features/popular_people/domain/usecases/get_person_images_usecase.dart';

part 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  final Person person;
  final GetPersonImageUseCase personImagesUseCase;

  PersonDetailsCubit({required this.person, required this.personImagesUseCase})
    : super(PersonDetailsInitial(person: person));

  static PersonDetailsCubit get(context) => BlocProvider.of(context);

  void getPersonImages() async {
    emit(PersonDetailsLoading());
    final result = await personImagesUseCase.call(id: person.id.toString());
    result.fold(
      (failure) => emit(PersonDetailsFailed(message: failure.message)),
      (images) => emit(PersonDetailsLoaded(images: images)),
    );
  }
}
