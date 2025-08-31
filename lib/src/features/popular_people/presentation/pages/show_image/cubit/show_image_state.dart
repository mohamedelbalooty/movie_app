part of 'show_image_cubit.dart';

@immutable
sealed class ShowImageState {}

final class ShowImageInitial extends ShowImageState {
  final String filePath;

  ShowImageInitial({required this.filePath});
}
