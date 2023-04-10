part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageIdle extends HomePageState {
  final String displayName;
  List<Playlist>? playlist;
  List<Album>? latestReleases;
  HomePageIdle({required this.displayName, this.playlist, this.latestReleases});
}
