import 'dart:convert';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/PreferencesService.dart';
import 'package:http/http.dart' as http;


class SpotifyService {

  Future<List<Track>> getRecommendedTracks() async {
    String baseUrl = 'https://api.spotify.com/v1/recommendations';
    String? accessToken = await PreferencesService.getAccessToken();
    
    final response = await http.get(
      Uri.parse('$baseUrl?seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA&max_popularity=90'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("warr hore ${data['tracks']}");
      final List<dynamic> tracklistsJson = data['tracks'];

      return tracklistsJson.map((trackJson) {
        return Track(
          name: trackJson['name'],
          trackuri: trackJson['uri'],
          imageUrl: trackJson['album']['images']?[0]['url'],
          artistName: trackJson['artists'][0]['name'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch Spotify playlists: ${response.statusCode}');
    }
  }

    Future<List<Track>?> getUsersSavedTracks() async {
      String baseUrl = 'https://api.spotify.com/v1/me/tracks';
    String? accessToken = await PreferencesService.getAccessToken();
    
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
     final List<dynamic> tracklistsJson = data['items'];
     final List<Track> tracks = tracklistsJson.map((tracklistsJson) {
        return Track(
            name: tracklistsJson['track']['name'],
            trackuri: tracklistsJson['track']['uri'],
            imageUrl: tracklistsJson['track']['album']['images']?[0]['url'],
            artistName: tracklistsJson['track']['artists'][0]['name']);
      }).toList();

  return tracks;
    } else {
      throw Exception('Failed to fetch Spotify playlists: ${response.statusCode}, ${response.body}');
    }
  }

  Future<void> playTrack(String uri) async {
    String? accessToken = await PreferencesService.getAccessToken();
    await http.put(
      Uri.parse('https://api.spotify.com/v1/me/player/play'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'uris': [uri]}),
    );
  }

  Future<void> pauseTrack() async {
    String? accessToken = await PreferencesService.getAccessToken();
    await http.put(
      Uri.parse('https://api.spotify.com/v1/me/player/pause'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
  }
}
