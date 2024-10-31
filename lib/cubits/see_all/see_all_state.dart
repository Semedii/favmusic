part of 'see_all_cubit.dart';

class SeeAllState {}

class SeeAllInitial extends SeeAllState {}

class SeeAllLoading extends SeeAllState {}

class SeeAllIdle extends SeeAllState {
  final List<Track>? tracks;
  final bool isPlaying;

  SeeAllIdle({this.tracks, this.isPlaying = false});

  SeeAllIdle copyWith({List<Track>? tracks, bool? isPlaying}) {
    return SeeAllIdle(
      tracks: tracks ?? this.tracks,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
