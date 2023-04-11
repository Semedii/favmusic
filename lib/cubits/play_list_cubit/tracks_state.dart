part of 'tracks_cubit.dart';

@immutable
abstract class TrackState {}

class TrackInitial extends TrackState {}

class TrackIdle extends TrackState {
  final List<Track> track;
  final bool isPlaying;
  final int selectedIndex;
  TrackIdle(
      {required this.track,
      required this.selectedIndex,
      required this.isPlaying});

  TrackIdle copyWith({
    List<Track>? track,
    int? selectedIndex,
    bool? isPlaying,
  }) {
    return TrackIdle(
        track: track ?? this.track,
        isPlaying: isPlaying ?? this.isPlaying,
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
