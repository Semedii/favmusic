import 'dart:convert';

import 'package:favmusic/model/album.dart';
import 'package:favmusic/model/play_lists.dart';
import 'package:favmusic/model/track.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SpotifyApi {
  static Future<Map<String, dynamic>> getSpotifyProfile(
      String? accessToken) async {
    final profileUrl = Uri.parse('https://api.spotify.com/v1/me');
    final response = await http.get(
      profileUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch Spotify profile');
    }
  }

  static Future<List<Playlist>> getPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/playlists'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> playlistsJson = data['items'];
      final List<Playlist> playlists = playlistsJson.map((playlistJson) {
        return Playlist(
          name: playlistJson['name'],
          link: playlistJson['external_urls']['spotify'],
          trackCount: playlistJson['tracks']['total'],
          image: playlistJson['images'].isNotEmpty
              ? playlistJson['images'][0]['url']
              : null,
        );
      }).toList();
      //getPlayListTracks("4KjIhbJJgZ4rMWsLMm7LBX");
      return playlists;
    } else {
      throw Exception('Failed to fetch Spotify playlists');
    }
  }

  static Future<List<Album>> getLatestRelease() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/browse/new-releases?country=US&limit=20'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> albumlistsJson = data['albums']['items'];
      final List<Album> album = albumlistsJson.map((albumlistsJson) {
        return Album(
            albumName: albumlistsJson['name'],
            imageUrl: albumlistsJson['images'].isNotEmpty
                ? albumlistsJson['images'][0]['url']
                : null,
            artistName: albumlistsJson['artists'][0]['name'],
            releaseDate: albumlistsJson['release_date'],
            trackCount: albumlistsJson['total_tracks']);
      }).toList();

      return album;
    } else {
      throw Exception('Failed to fetch Spotify playlists');
    }
  } 
static getPlayListTracks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/playlists/4KjIhbJJgZ4rMWsLMm7LBX/tracks'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> tracklistsJson = data['items'];
      final List<Track> track = tracklistsJson.map((tracklistsJson) {
        return Track(
          name: tracklistsJson['track']['name'],
          // imageUrl: tracklistsJson['track']['images'].isNotEmpty
          //       ? tracklistsJson['images'][0]['url']
          //       : null,
            artistName: tracklistsJson['track']['artists'][0]['name']);
            //releaseDate: tracklistsJson['release_date'],
            //trackCount: albumlistsJson['total_tracks']);
      }).toList();

      return track;
      
    } else {
      throw Exception('Failed to fetch Spotify playlists');
    }
  }
  
}
