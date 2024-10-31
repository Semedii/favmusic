import 'package:bloc/bloc.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';

part 'play_state.dart';

class PlayCubit extends Cubit<PlayState> {
  final SpotifyService spotifyService;
  PlayCubit(this.spotifyService) : super(PlayInitial());

  playTrack(Track playingTrack) async {
    var lastState = state as PlayInitial;
    if (lastState.isPlaying) {
      await spotifyService.pauseTrack();
      emit(lastState.copyWith(isPlaying: false));
    } else {
      await spotifyService.playTrack(playingTrack.trackuri);
      emit(lastState.copyWith(isPlaying: true));
    }
  }
}
