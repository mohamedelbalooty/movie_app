part of 'popular_people_cubit.dart';

@immutable
sealed class PopularPeopleState {}

final class PopularPeopleInitial extends PopularPeopleState {}

final class PopularPeopleLoading extends PopularPeopleState {}

final class PopularPeopleLoaded extends PopularPeopleState {
  final PeoplePage peoplePage;

  PopularPeopleLoaded({required this.peoplePage});
}

final class PopularPeopleFailed extends PopularPeopleState {
  final String message;

  PopularPeopleFailed({required this.message});
}
