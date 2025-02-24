import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<String?> authenticate() async {
    final clientId = dotenv.env['SPOTIFY_CLIENT_ID'];
    final redirectUri = dotenv.env['REDIRECT_URI'];

    if (clientId == null || redirectUri == null) {
      // ignore: avoid_print
      print('Client ID or Redirect URI is missing.');
      return null;
    }

    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            "https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=user-library-read%20user-read-private%20user-read-email%20user-read-playback-state%20user-modify-playback-state&response_type=token&state=123",
        callbackUrlScheme: 'waryaa',
      );

      final token = Uri.parse(result);
      String fragment = token.fragment;
      return Uri.parse('http://website/index.html?$fragment')
          .queryParameters['access_token'];
    } catch (e) {
      // ignore: avoid_print
      print('Authentication error: $e');
      return null;
    }
  }

  Future<bool> saveUsername(String? accessToken) async {
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

  Future<void> saveToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }
}
