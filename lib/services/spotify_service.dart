import 'dart:convert';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/preferences_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SpotifyService {
  Future<bool> isTokenValid(String? accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await prefs.setString('userName', data["display_name"]);
      return true;
    } else {
      return false;
    }
  }

  Future<List<Track>> getRecommendedTracks({bool isLimited = false}) async {
    String limit = isLimited ? "&limit=5" : "";
    String baseUrl = 'https://api.spotify.com/v1/search';
    String? accessToken = await PreferencesService.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=track$limit'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      final data = jsonDecode(response.body);
      final List<dynamic> tracklistsJson = data['tracks']['items'];

      List<Track> tracks = tracklistsJson.map((trackJson) {
        return Track(
          name: trackJson['name'],
          trackuri: trackJson['uri'],
          imageUrl: trackJson['album']['images']?[0]['url'],
          artistName: trackJson['artists'][0]['name'],
        );
      }).toList();

      return tracks; // This is now a List<Track>, which is wrapped in a Future by the async function.
    } catch (e) {
      throw Exception('Failed to fetch Spotify recommended tracks: $e');
    }
  }

  Future<List<Track>?> getUsersSavedTracks({bool isLimited = false}) async {
    String limit = isLimited ? "&limit=5" : "";
    String baseUrl = 'https://api.spotify.com/v1/me/tracks?$limit';
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
      throw Exception(
          'Failed to fetch users saved playlist: ${response.statusCode}, ${response.body}');
    }
  }

  Future<List<Track>?> getUsersSavedEpisodes({bool isLimited = false}) async {
    String limit = isLimited ? "&limit=5" : "";
    String baseUrl = 'https://api.spotify.com/v1/me/episodes?$limit';
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
            name: tracklistsJson['episode']['name'],
            trackuri: tracklistsJson['episode']['uri'],
            imageUrl: tracklistsJson['episode']['images']?[0]['url'],
            artistName: tracklistsJson['episode']['show']['publisher']);
      }).toList();

      return tracks;
    } else {
      throw Exception(
          'Failed to fetch users saved episodes: ${response.statusCode}, ${response.body}');
    }
  }

  Future<void> playTrack(String uri) async {
    String? accessToken = await PreferencesService.getAccessToken();
    var response = await http.put(
      Uri.parse('https://api.spotify.com/v1/me/player/play'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'uris': [uri]
      }),
    );
    // ignore: avoid_print
    print("aaa 12 ${response.body}");
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
