part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserIdle extends UserState {
  final String displayName;
  final String? imageUrl;
  List<Playlist>? playlist;
  List<Album>? latestReleases;
  UserIdle({required this.displayName, this.imageUrl, this.playlist, this.latestReleases});
}
