import 'package:bloc/bloc.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';
import 'package:flutter/material.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  final SpotifyService spotifyService;
  HomepageCubit(this.spotifyService) : super(HomepageInitial());

  initializePage() async {
    final List<Track> recommendedTracks =
        await spotifyService.getRecommendedTracks();
    final List<Track>? usersSavedTracks =
        await spotifyService.getUsersSavedTracks();
    emit(
      HomepageIdle(
        recommendedTracks: recommendedTracks,
        usersSavedTracks: usersSavedTracks,
      ),
    );
  }
}
