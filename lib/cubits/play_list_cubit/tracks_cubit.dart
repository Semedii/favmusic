import 'package:bloc/bloc.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:meta/meta.dart';

import '../../model/track.dart';

part 'tracks_state.dart';

class TrackCubit extends Cubit<TrackState> {
  TrackCubit() : super(TrackInitial());
  
  initializePage(String link) async {
    List<Track> trackList = await SpotifyApi.getPlayListTracks(link);
    emit(TrackIdle(track: trackList, isPlaying: false));
  }

  play(String uri) async {
    TrackIdle lastState = state as TrackIdle;
    if (lastState.isPlaying) {
      SpotifyApi.PauseTrack();
      emit(lastState.copyWith(isPlaying: false));
    } else {
      SpotifyApi().playTrack(uri);
      emit(lastState.copyWith(isPlaying: true));
    }
  }
}
