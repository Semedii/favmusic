part of 'see_all_cubit.dart';

class SeeAllState {}

class SeeAllInitial extends SeeAllState {}

class SeeAllLoading extends SeeAllState {}

class SeeAllIdle extends SeeAllState {
  final List<Track>? tracks;
  final bool isPlaying;
  final int playingIndex;
  final bool isUpdating;

  SeeAllIdle({
    this.tracks,
    this.isPlaying = false,
    this.playingIndex = -1,
    this.isUpdating = false,
  });

  SeeAllIdle copyWith({
    List<Track>? tracks,
    bool? isPlaying,
    int? playingIndex,
    bool? isUpdating,
  }) {
    return SeeAllIdle(
      tracks: tracks ?? this.tracks,
      isPlaying: isPlaying ?? this.isPlaying,
      playingIndex: playingIndex ?? this.playingIndex,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}
