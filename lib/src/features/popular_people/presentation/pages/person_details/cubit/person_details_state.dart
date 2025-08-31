part of 'person_details_cubit.dart';

@immutable
sealed class PersonDetailsState {}

final class PersonDetailsInitial extends PersonDetailsState {
  final Person person;

  PersonDetailsInitial({required this.person});
}

final class PersonDetailsLoading extends PersonDetailsState {}

final class PersonDetailsLoaded extends PersonDetailsState {
  final List<Image> images;

  PersonDetailsLoaded({required this.images});
}

final class PersonDetailsFailed extends PersonDetailsState {
  final String message;

  PersonDetailsFailed({required this.message});
}
