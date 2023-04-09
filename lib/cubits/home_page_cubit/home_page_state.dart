part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}


class HomePageInitial extends HomePageState {}

class HomePageIdle extends HomePageState {
  final String DisplayName;

  HomePageIdle({required this.DisplayName});
}
