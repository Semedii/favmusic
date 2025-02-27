import 'package:bloc/bloc.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/spotify_service.dart';

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

  playTrack(Track playingTrack, int playingIndex) async {
    var lastState = state as SeeAllIdle;
    emit(lastState.copyWith(isUpdating: true));
    if (lastState.isPlaying) {
      await spotifyService.pauseTrack();
      if (lastState.playingIndex == playingIndex) {
        emit(
          lastState.copyWith(
            isPlaying: false,
            playingIndex: -1,
            isUpdating: false,
          ),
        );
        return;
      }
    }
    await spotifyService.playTrack(playingTrack.trackuri);
    emit(
      lastState.copyWith(
        isPlaying: true,
        playingIndex: playingIndex,
        isUpdating: false,
      ),
    );
  }
}
