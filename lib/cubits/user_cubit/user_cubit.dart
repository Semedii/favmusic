import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:favmusic/model/album.dart';
import 'package:favmusic/model/play_lists.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  initializePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    var spotifyProfile = await SpotifyApi.getSpotifyProfile(accessToken);
    String displayName = spotifyProfile['display_name'];
    Image imageUrl = spotifyProfile['images'].isNotEmpty
        ? Image.network(spotifyProfile['images'][0])
        : Image.asset('assets/images/default_user.jpeg');

    List<Playlist> playLists = await _getPlaylists();
    List<Album> latestReleases = await _getLatestRelease();
    emit(UserIdle(
        displayName: displayName,
        imageUrl: imageUrl,
        playlist: playLists,
        latestReleases: latestReleases));
  }

  Future<List<Playlist>> _getPlaylists() async {
    final List<Playlist> playlists = await SpotifyApi.getPlaylists();

    return playlists;
  }

  Future<List<Album>> _getLatestRelease() async {
    final List<Album> latestReleases = await SpotifyApi.getLatestRelease();
    return latestReleases;
  }
}
