import 'package:bloc/bloc.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:meta/meta.dart';

import '../../model/track.dart';

part 'play_list_track_state.dart';

class PlayListTrackCubit extends Cubit<PlayListTrackState> {
  PlayListTrackCubit() : super(PlayListTrackInitial());

  initializePage() async {
    List<Track> trackList = await SpotifyApi.getPlayListTracks();
    emit(PlayListTrackIdle(track: trackList));
  }

  play(String uri){
  SpotifyApi().playTrack(uri);
  }
}
