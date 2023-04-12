import 'package:bloc/bloc.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:meta/meta.dart';

import '../../model/track.dart';

part 'tracks_state.dart';

class TrackCubit extends Cubit<TrackState> {
  TrackCubit() : super(TrackInitial());

  initializePage(String link, bool isalbum) async {
    if (isalbum) {
      List<Track> trackList = await SpotifyApi.getAlbumTracks(link);
      emit(TrackIdle(track: trackList, isPlaying: false, selectedIndex: -1));
    } else {
      List<Track> trackList = await SpotifyApi.getPlayListTracks(link);
      emit(TrackIdle(track: trackList, isPlaying: false, selectedIndex: -1));
    }
  }

  play(String uri, int index) async {
    TrackIdle lastState = state as TrackIdle;
    if (lastState.isPlaying) {
      SpotifyApi.PauseTrack();
      emit(lastState.copyWith(isPlaying: false, selectedIndex: -1));
    } else {
      SpotifyApi().playTrack(uri);
      emit(lastState.copyWith(isPlaying: true, selectedIndex: index));
    }
  }
}
