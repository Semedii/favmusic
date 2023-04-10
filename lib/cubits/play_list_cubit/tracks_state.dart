part of 'tracks_cubit.dart';

@immutable
abstract class TrackState {}

class TrackInitial extends TrackState {}

class TrackIdle extends TrackState {
  final List<Track> track;
  final bool isPlaying;
  TrackIdle({required this.track, required this.isPlaying });
  
  TrackIdle copyWith({
    List<Track>? track,
    bool? isPlaying,
  }) {
    return TrackIdle(
      track: track ?? this.track,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}