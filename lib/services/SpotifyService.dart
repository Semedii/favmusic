import 'dart:convert';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/PreferencesService.dart';
import 'package:http/http.dart' as http;


class SpotifyService {
  final String baseUrl = 'https://api.spotify.com/v1/recommendations';

  Future<List<Track>> getRecommendedTracks() async {
    String? accessToken = await PreferencesService.getAccessToken();
    
    final response = await http.get(
      Uri.parse('$baseUrl?seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA&max_popularity=90'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
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
