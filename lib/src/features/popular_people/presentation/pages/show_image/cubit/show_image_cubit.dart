import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_image_state.dart';

class ShowImageCubit extends Cubit<ShowImageState> {
  final String filePath;

  ShowImageCubit({required this.filePath})
    : super(ShowImageInitial(filePath: filePath));

  static ShowImageCubit get(context) => BlocProvider.of(context);
}
