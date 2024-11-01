import 'package:bloc/bloc.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/spotify_service.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  final SpotifyService spotifyService;
  HomepageCubit(this.spotifyService) : super(HomepageInitial());

  initializePage() async {
        final List<Track> recommendedTracks =
        await spotifyService.getRecommendedTracks(isLimited: true);
        final List<Track>? usersSavedEpisodes =
        await spotifyService.getUsersSavedEpisodes(isLimited: true);
    final List<Track>? usersSavedTracks =
        await spotifyService.getUsersSavedTracks(isLimited: true);
    emit(
      HomepageIdle(
        usersSavedEpisodes: usersSavedEpisodes,
        recommendedTracks: recommendedTracks,
        usersSavedTracks: usersSavedTracks,
      ),
    );
  }
}
