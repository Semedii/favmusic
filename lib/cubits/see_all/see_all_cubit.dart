import 'package:bloc/bloc.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';

part 'see_all_state.dart';

class SeeAllCubit extends Cubit<SeeAllState> {
  final SpotifyService spotifyService;
  SeeAllCubit(this.spotifyService) : super(SeeAllInitial());

  fetchTracks(String category) async {
    emit(SeeAllLoading());
    List<Track>? tracks;
    if (category == "Popular Today") {
      tracks = await spotifyService.getRecommendedTracks();
      emit(SeeAllIdle(tracks: tracks));
    } else if (category == "My Saved Episodes") {
      tracks = await spotifyService.getUsersSavedEpisodes();
      emit(SeeAllIdle(tracks: tracks));
    } else if (category == "My Saved Tracks") {
      tracks = await spotifyService.getUsersSavedTracks();
      emit(SeeAllIdle(tracks: tracks));
    }
  }

    playTrack(Track playingTrack) async {
    var lastState = state as SeeAllIdle;
    if (lastState.isPlaying) {
      await spotifyService.pauseTrack();
      emit(lastState.copyWith(isPlaying: false));
    } else {
      await spotifyService.playTrack(playingTrack.trackuri);
      emit(lastState.copyWith(isPlaying: true));
    }
  }
}
