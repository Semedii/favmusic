part of 'homepage_cubit.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomepageIdle extends HomepageState {
  List<Track>? recommendedTracks;
  List<Track>? usersSavedTracks;
  List<Track>? usersSavedEpisodes;
  HomepageIdle({this.recommendedTracks, this.usersSavedTracks, this.usersSavedEpisodes});
}
