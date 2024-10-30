part of 'homepage_cubit.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomepageIdle extends HomepageState {
  List<Track>? recommendedTracks;
  HomepageIdle({this.recommendedTracks});
}
