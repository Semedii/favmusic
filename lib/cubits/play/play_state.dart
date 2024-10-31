part of 'play_cubit.dart';

class PlayState {}

class PlayInitial extends PlayState {
  final bool isPlaying;

  PlayInitial({this.isPlaying = false});

  PlayInitial copyWith({bool? isPlaying}) {
    return PlayInitial(isPlaying: isPlaying ?? this.isPlaying);
  }
}
