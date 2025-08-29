import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_image_state.dart';

class ShowImageCubit extends Cubit<ShowImageState> {
  ShowImageCubit() : super(ShowImageInitial());

  static ShowImageCubit get(context) => BlocProvider.of(context);
}
