import 'dart:convert';

import 'package:http/http.dart' as http;

class SpotifyApi {


  static Future<Map<String, dynamic>> getSpotifyProfile(String? accessToken) async {
   
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
}