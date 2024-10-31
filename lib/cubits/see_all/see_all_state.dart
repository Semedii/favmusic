part of 'see_all_cubit.dart';

class SeeAllState {}

class SeeAllInitial extends SeeAllState{}

class SeeAllLoading extends SeeAllState{}

class SeeAllIdle extends SeeAllState {
  final List<Track>? tracks;

  SeeAllIdle({this.tracks});

  SeeAllIdle copyWith({List<Track>? tracks}) {
    return SeeAllIdle(tracks: tracks ?? this.tracks);
  }
}
