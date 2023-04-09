import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

class SpotifyApi {
  static Future<String> getAccessToken() async {
    await FlutterConfig.loadEnvVariables();
    final clientId = FlutterConfig.get('SPOTIFY_CLIENT_ID');
    final clientSecret = FlutterConfig.get('SPOTIFY_CLIENT_SECRET');

    final tokenUrl = Uri.parse('https://accounts.spotify.com/api/token');
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';
    final response = await http.post(
      tokenUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': basicAuth,
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['access_token'];
      return token;
    } else {
      throw Exception('Failed to get access token');
    }
  }
}
