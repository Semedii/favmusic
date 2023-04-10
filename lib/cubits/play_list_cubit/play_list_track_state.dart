part of 'play_list_track_cubit.dart';

@immutable
abstract class PlayListTrackState {}

class PlayListTrackInitial extends PlayListTrackState {}

class PlayListTrackIdle extends PlayListTrackState {
  final List<Track> track;

  PlayListTrackIdle({required this.track});
}