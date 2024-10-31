part of 'play_cubit.dart';

class PlayState {}

class PlayInitial extends PlayState {
  final bool isPlaying;
  final Track? playingTrack;

  PlayInitial({this.isPlaying = false, this.playingTrack});

  PlayInitial copyWith({bool? isPlaying, Track? playingTrack}) {
    return PlayInitial(
      isPlaying: isPlaying ?? this.isPlaying,
      playingTrack: playingTrack ?? this.playingTrack,
    );
  }
}
